import 'package:dietitian_dashboard/diary/diary_display.dart';
import 'package:flutter/material.dart';
import 'package:viatolea_api/api.dart';

class QuickOverview extends StatefulWidget{
  final List<MealsAndSymptoms> finalTable;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? timeframe;
  final List<MealsAndSymptoms>? selectedSymptoms;
  final TextEditingController controllerFructose;
  final TextEditingController controllerLactose;
  final TextEditingController controllerSorbitol;
  final bool glutenWithTraces;

  const QuickOverview({
    super.key,
    required this.finalTable,
    required this.startDate,
    required this.endDate,
    required this.timeframe,
    required this.selectedSymptoms,
    required this.controllerFructose,
    required this.controllerLactose,
    required this.controllerSorbitol,
    required this.glutenWithTraces,
    });

    @override
    State<QuickOverview> createState() => _QuickOverviewState();
}

class _QuickOverviewState extends State<QuickOverview>{

  late List<MealsAndSymptoms> finalTable;
  late DateTime startDate;
  late DateTime endDate;
  late int timeframe;
  late List<MealsAndSymptoms> selectedSymptoms;

  // Controllers for being able to change threshold of allergens
  late final TextEditingController controllerFructose;
  late final TextEditingController controllerLactose;
  late final TextEditingController controllerSorbitol;

  // Checkbox for gluten (with/without contains_traces)
  late bool glutenWithTraces;

  @override
  void initState(){
    super.initState();
    finalTable = widget.finalTable;
    startDate = widget.startDate ?? finalTable[0].dateTime;
    endDate = widget.endDate ?? DateTime.now();
    timeframe = widget.timeframe ?? 8;  // Should be 8 by default
    selectedSymptoms = widget.selectedSymptoms ?? [];

    controllerFructose = widget.controllerFructose;
    controllerLactose = widget.controllerLactose;
    controllerSorbitol = widget.controllerSorbitol;
    glutenWithTraces = widget.glutenWithTraces;
  }
  
  @override
  Widget build(BuildContext context){

    // save aall logged days, and all days with symptoms
    List<DateTime> loggedDays = [];
    List<DateTime> loggedSymptomDays = [];
    for(var day in finalTable){
      DateTime current = DateTime(day.dateTime.year, day.dateTime.month, day.dateTime.day);

      // only count if in given timeperiod
      if(current.isAfter(DateTime(startDate.year, startDate.month, startDate.day).subtract(Duration(days: 1))) && current.isBefore(DateTime(endDate.year, endDate.month, endDate.day).add(Duration(days: 1)))){
        // only log days (not time), and no duplicates (to determine amount of logged days)
        if(!loggedDays.contains(current)){
          loggedDays.add(current);
        }

        // log all days with symptoms
        if(day.isSymptom && !loggedSymptomDays.contains(current)){
          loggedSymptomDays.add(current);
        }
      }
    }

    // find out how many meals have missing information
    int countMealsMissingNutritionalData = 0;
    for(var entry in finalTable){
      DateTime current = DateTime(entry.dateTime.year, entry.dateTime.month, entry.dateTime.day);

      if((entry.isMissingNutritionFacts ?? false) && current.isAfter(DateTime(startDate.year, startDate.month, startDate.day).subtract(Duration(days: 1))) && current.isBefore(DateTime(endDate.year, endDate.month, endDate.day).add(Duration(days: 1)))){

        // find out if data had been updated
        bool stillMissingNutritionalFacts = false;
        for(var comp in entry.mealComponents!){
          if(comp.ingredientId == null){
            stillMissingNutritionalFacts = true;
          }
        }
        // only increase counter if data has not been updated
        if(stillMissingNutritionalFacts){
          countMealsMissingNutritionalData++;
        }
      }
    }

    // calculate if allergy symptom occurs, is yes, add to list
    List<(MealsAndSymptoms, int)> allergySymptomAndOccurance = [];
    for(var entry in finalTable){

      if((entry.allergyCandidate ?? false) && entry.dateTime.isAfter(DateTime(startDate.year, startDate.month, startDate.day)) && entry.dateTime.isBefore(DateTime(endDate.year, endDate.month, endDate.day).add(Duration(days: 1)))){

        //check if already in list
        bool alreadyInList = false;
        for(var inList in allergySymptomAndOccurance){
          if(inList.$1.text == entry.text){
            alreadyInList = true;
          }
        }

        //if already in list, then increase counter, else add
        if(alreadyInList){
          for(var i = 0; i<allergySymptomAndOccurance.length; i++){
            
            if(allergySymptomAndOccurance[i].$1.text == entry.text){
              allergySymptomAndOccurance[i] = (allergySymptomAndOccurance[i].$1, (allergySymptomAndOccurance[i].$2 + 1));
            }
          }
        }
        else{
          allergySymptomAndOccurance.add((entry, 1));
        }
      }
    }

    // If allergysymptoms occured, sort by frequency
    allergySymptomAndOccurance.sort((a, b) => b.$2.compareTo(a.$2));

    // Create Text that will be given in case of allergy symptom
    String textAllergySymptoms = "";

    // Only make Text if Allergysymptom is given
    if(allergySymptomAndOccurance.isNotEmpty){
      for(var e in allergySymptomAndOccurance){
        textAllergySymptoms += " ${e.$1.text} (${e.$2})";

        // If not last Allergysymptom, then add a comma
        if(e != allergySymptomAndOccurance.last){
          textAllergySymptoms += ",\n";
        }
      }
    }


    // compute likelihoods (based on last 2 weeks)
    List<int> likelyIntolerance = computeLikelihoodsIntolerances(selectedSymptoms, finalTable, timeframe, controllerFructose, controllerLactose, controllerSorbitol, glutenWithTraces);
    /* List likelyIntolerance buildup:
    [0]: fructose,
    [1]: lactose,
    [2]: sorbitol,
    [3]: gluten,
    */
    int highestValue = 0;
    String highestSymptom = "";
    int symptomCount = likelyIntolerance[4];

    for(var i = 0; i<likelyIntolerance.length - 1; i++){ // -1 to not count allSymptom value
      if(likelyIntolerance[i] > highestValue){
        highestValue = likelyIntolerance[i];
        if(i == 0){
          highestSymptom = "Fruktose";
        }
        if(i == 1){
          highestSymptom = "Laktose";
        }
        if(i == 2){
          highestSymptom = "Sorbit";
        }
        if(i == 3){
          highestSymptom = "Gluten";
        }
      }
    }
  

    // Widget
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Schnelle Übersicht",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            "Eingetragene Tage: ${loggedDays.length}\nDavon mit Symptomen: ${loggedSymptomDays.length}",
                            textAlign: TextAlign.center,
                          )
                        )
                      ),
                      SizedBox(
                        width: 1,
                        child: Container(
                          color: Colors.grey,
                        ),
                      ),
                      Expanded(
                          child: Center(
                            child: Text(
                              "Mahlzeiten mit unvollständigen Infos: $countMealsMissingNutritionalData",
                              textAlign: TextAlign.center,

                            ),
                        )
                      )
                    ],
                  )
                ),
                SizedBox(
                        height: 1,
                        child: Container(
                          color: Colors.grey,
                        ),
                      ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child:  allergySymptomAndOccurance.isNotEmpty 
                            ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                child: Tooltip(
                                  message: "Folgende Allergiesymptome sind aufgetreten:\n$textAllergySymptoms",
                                  textAlign: TextAlign.center,
                                  child: Icon(
                                    Icons.warning,
                                    color: Colors.red,),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                      "Achtung, Allergiesymptom(e)!",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                ),
                              ],
                            )
                            : Text(
                              "Keine Allergiesymptome vorgekommen",
                              textAlign: TextAlign.center,
                            ), // if no AllergySymptoms, then leave empty
                        )
                      ),
                      SizedBox(
                        width: 1,
                        child: Container(
                          color: Colors.grey,
                        ),
                      ),
                      Expanded(child: Center(
                        child: highestValue == 0 
                        ? Text(
                          "Keine Einträge in den letzten 14 Tagen",
                          textAlign: TextAlign.center,)
                        : Text(
                          "Auffällig:\n$highestSymptom (letzten 14 Tage):\nVor $highestValue/$symptomCount (${((highestValue/symptomCount)*100).ceil()}%) Symptomen erhöhte Werte",
                          textAlign: TextAlign.center,
                        ),))
                    ],
                  )
                )
              ],
            ) //TODO: create over view --> summed facts etc
          ),        
        ],
      ),
    );
  }
}

List<int> computeLikelihoodsIntolerances(List<MealsAndSymptoms> selectedSymptoms, List<MealsAndSymptoms> finalTable, int timeframe, TextEditingController controllerFructose, TextEditingController controllerLactose, TextEditingController controllerSorbitol, bool withContainTraces){

  List<List<MealsAndSymptoms>> allTimeframes = [];
  List<MealsAndSymptoms> symptoms = [];

  DateTime end = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime start = end.subtract(Duration(days: 14));

  double fructoseThreshold = (double.tryParse((controllerFructose.text == "" ? "0" : controllerFructose.text).trim().toString().replaceAll(",", ".").replaceAll(" ", "")) ?? 0.0);
  double lactoseThreshold = (double.tryParse((controllerLactose.text == "" ? "0" : controllerLactose.text).trim().toString().replaceAll(",", ".").replaceAll(" ", "")) ?? 0.0);
  double sorbitolThreshold = (double.tryParse((controllerSorbitol.text == "" ? "0" : controllerSorbitol.text).trim().toString().replaceAll(",", ".").replaceAll(" ", "")) ?? 0.0);

  //If no Symptom is selected, then use all
  if(selectedSymptoms.isEmpty){
    for(var entry in finalTable){
      // if it is a symptom
      if(entry.isSymptom && entry.dateTime.isAfter(start)){
        symptoms.add(entry);
      }
    }
  }
  else{
    for(var entry in finalTable){
      // if it is a symptom
      if(entry.isSymptom && entry.dateTime.isAfter(start)){
        if(selectedSymptoms.map((a) => a.text).toList().contains(entry.text)){
          symptoms.add(entry);
        }
      }
    }
  }

  // create the clusters in timeframe before
  for(var s in symptoms){
    DateTime withinTimeframe = s.dateTime.subtract(Duration(hours: timeframe));
    List<MealsAndSymptoms> sublist = [];

    for(var e in finalTable){
      if((e.dateTime.isAfter(withinTimeframe) && e.dateTime.isBefore(s.dateTime)) || e.dateTime.isAtSameMomentAs(s.dateTime)){
        sublist.add(e);
      } 
    }
    allTimeframes.add(sublist);
  }

  // values for summing high count
  int allSymptoms = allTimeframes.length;
  int highFructose = 0;
  int highLactose = 0;
  int highSorbitol = 0;
  int glutenCount = 0;

  for(var cluster in allTimeframes){
    double currentFructose = 0;
    double currentLactose = 0;
    double currentSorbitol = 0;
    GlutenAmount currentGluten = GlutenAmount.GLUTEN_FREE;

    for(var c in cluster){
      currentFructose += c.fructose ?? 0;
      currentLactose += c.lactose ?? 0;
      currentSorbitol += c.sorbitol ?? 0;
      currentGluten = (c.gluten == GlutenAmount.CONTAINS_GLUTEN || currentGluten == GlutenAmount.CONTAINS_GLUTEN 
                                ? GlutenAmount.CONTAINS_GLUTEN 
                                : (c.gluten == GlutenAmount.CONTAINS_TRACES || currentGluten == GlutenAmount.CONTAINS_TRACES
                                      ? GlutenAmount.CONTAINS_TRACES
                                      : currentGluten
                                  )
                    );
    }

    if(currentFructose >= fructoseThreshold){
      highFructose++;
    }
    if(currentLactose >= lactoseThreshold){
      highLactose++;
    }
    if(currentSorbitol >= sorbitolThreshold){
      highSorbitol++;
    }
    if((withContainTraces ? (currentGluten == GlutenAmount.CONTAINS_GLUTEN || currentGluten == GlutenAmount.CONTAINS_TRACES) : currentGluten == GlutenAmount.CONTAINS_GLUTEN)){
      glutenCount++;
    }
  }


  //TODO
  return [highFructose, highLactose, highSorbitol, glutenCount, allSymptoms];
}