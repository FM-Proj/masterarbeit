import 'package:dietitian_dashboard/diary/Widgets/BarDiagram.dart';
import 'package:dietitian_dashboard/diary/diary_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:viatolea_api/api.dart';

class ZusammenhangAllergeneSymptome extends StatefulWidget{
  
  final List<MealsAndSymptoms> finalTable;
  final int? timeframe;
  final DateTime? startDate;
  final DateTime? endDate;
  final Function(int?) updateAllergenSymptomTable;
  final Function(bool) callTimeframeSelector;
  final bool summedView;
  final TextEditingController controllerFructose;
  final TextEditingController controllerLactose;
  final TextEditingController controllerSorbitol;
  final bool glutenWithTraces;
  final Function(bool, bool) setGlutenWithTraces;
  final List<MealsAndSymptoms> selectedSymptoms;
  final Function(List<List<MealsAndSymptoms>>) updateAllClusters;

  const ZusammenhangAllergeneSymptome({
    super.key,
    required this.finalTable,
    required this.timeframe,
    required this.startDate,
    required this.endDate,
    required this.updateAllergenSymptomTable,
    required this.callTimeframeSelector,
    required this.summedView,
    required this.controllerFructose,
    required this.controllerLactose,
    required this.controllerSorbitol,
    required this.glutenWithTraces,
    required this.setGlutenWithTraces,
    required this.selectedSymptoms,
    required this.updateAllClusters,
    });

    @override
    State<ZusammenhangAllergeneSymptome> createState() => _ZusammenhangAllergeneSymptomeState();
}

// widget itself
class _ZusammenhangAllergeneSymptomeState extends State<ZusammenhangAllergeneSymptome>{

  late List<MealsAndSymptoms> finalTable;
  late int timeframe;
  late DateTime startDate;
  late DateTime endDate;
  late Function(int?) updateAllergenSymptomTable;
  late Function(bool) callTimeframeSelector;
  late bool summedView;
  late Function(bool, bool) setGlutenWithTraces;
  late List<MealsAndSymptoms> selectedSymptoms;
  late Function(List<List<MealsAndSymptoms>>) updateAllClusters;

  // Controllers for being able to change threshold of allergens
  late final TextEditingController controllerFructose;
  late final TextEditingController controllerLactose;
  late final TextEditingController controllerSorbitol;

  // Checkbox for gluten (with/without contains_traces)
  late bool glutenWithTraces;

  // CheckBox only intolerance symptoms
  late bool typicalIntoleranceSymptoms;

  // refresh the diagrams
  late int refreshDiagram;//TODO: key bleibt gleich, herausfinden wie garantiert weiter läuft!!!!!

  @override
  void initState(){
    super.initState();
    finalTable = widget.finalTable;
    timeframe = widget.timeframe ?? 0;
    startDate = widget.startDate ?? finalTable[0].dateTime;
    endDate = widget.endDate ?? DateTime.now();
    updateAllergenSymptomTable = widget.updateAllergenSymptomTable;
    callTimeframeSelector = widget.callTimeframeSelector;
    summedView = widget.summedView;
    controllerFructose = widget.controllerFructose;
    controllerLactose = widget.controllerLactose;
    controllerSorbitol = widget.controllerSorbitol;
    glutenWithTraces = widget.glutenWithTraces;
    setGlutenWithTraces = widget.setGlutenWithTraces;
    selectedSymptoms = widget.selectedSymptoms;
    updateAllClusters = widget.updateAllClusters;

    // initialize refreshDiagram
    refreshDiagram = 0;

    // set bool
    typicalIntoleranceSymptoms = false;

    // for selected Symptoms: if List is empty, then fill with all Symptoms
    if(selectedSymptoms.isEmpty){
      for(var entry in finalTable){
        if(entry.isSymptom){
          bool notInList = true;
          for(var e in selectedSymptoms){
            // if already added, then make bool false
            if(e.text == entry.text){
              notInList = false;
            }
          }
          if(notInList){
            selectedSymptoms.add(entry);
          }
        }
      }
    }
  }

  List<List<MealsAndSymptoms>> clusterMealsWithoutSymptoms(List<MealsAndSymptoms> finalTable, int timeframe){

    // catch invalid timeframe
    if(timeframe == 0){
      return [[]];
    }
    
    // returned list
    List<List<MealsAndSymptoms>> mealsEatenWithoutSymptoms = [];

    // Have two indices determine cluster
    int j = 0;

    for(int i = 0; i < finalTable.length; i++){
      if(!finalTable[i].isSymptom && finalTable[i].dateTime.isAfter(DateTime(startDate.year, startDate.month, startDate.day)) && finalTable[i].dateTime.isBefore(DateTime(endDate.year, endDate.month, endDate.day).add(Duration(days: 1)))){
        while(j < finalTable.length){

          // break if timeframe reached
          if(finalTable[j].dateTime.difference(finalTable[i].dateTime) > Duration(hours: timeframe)){
            break;
          }
          
          // if a symptom occurred, then stop current cluster
          if(finalTable[j].isSymptom){
            // increase j so Symptom is final element in table
            j++;
            break;
          }

          // increase for while-loop
          j++;
        }

        // Cluster of meals per timeframe is now from i to j-1
        if(j - 1 >= i){
          if(i == 0 || finalTable[j - 1].dateTime.difference(finalTable[i - 1].dateTime) > Duration(hours: timeframe) || (i > 0 && finalTable[i - 1].isSymptom)){
            
            // to determine sublist of meals not leading to symptoms
            List<MealsAndSymptoms> subList = [];
            for(var x in finalTable.sublist(i, j)){
              // filter out meals that lead to symptoms, and symptoms themselves
              if(!(x.leadToSymptom ?? true)){
                subList.add(x);
              }
            }

            if(subList.isNotEmpty){
              mealsEatenWithoutSymptoms.add(subList);
            }
          }
        }
      }
      else{
        // if a symptom occurs, then increase j to next element
        j++;
      }
      
    }
    // returns all max clusters of timeframe duration found in finalTable
    return mealsEatenWithoutSymptoms;
  }
  
  @override
  Widget build(BuildContext context){

    // For adjusting the Table widths, the width of the colums are needed
    double measureWidthOfValue(String value, BuildContext context){
      final TextPainter painter = TextPainter(
        text: TextSpan(
          text: value,
          style: Theme.of(context).dataTableTheme.dataTextStyle
        ),
        maxLines: 1,
        textDirection: TextDirection.ltr,
      )..layout();

      return painter.size.width;
    }

    List<(String, DateTime)> symptomeUndZeiten = [];

    // Sum allergen + symptom combos
    for(var entry in finalTable){
      if(entry.dateTime.isAfter(DateTime(startDate.year, startDate.month, startDate.day)) && entry.dateTime.isBefore(DateTime(endDate.year, endDate.month, endDate.day).add(Duration(days: 1)))){
        if(entry.isSymptom){
          symptomeUndZeiten.add((entry.text, entry.dateTime));
        }
      }
    }

    // Erstellt Liste von Symptomen und alle Zeiten wo aufgetreten
    Map<String, List<DateTime>> groupBySymptom(List<(String, DateTime)> items){
      final map = <String, List<DateTime>>{};
      for (final i in items){
        (map[i.$1] ??= <DateTime>[]).add(i.$2); 
      }

      return map;
    }
    final listeVorkommen = groupBySymptom(symptomeUndZeiten);

    // create list of all symptoms (for output later)
    List<String> alleSymptome = [];
    for(var symptom in listeVorkommen.entries){
      alleSymptome.add(symptom.key.toString());
    }

    //Create List, with symptoms and meals in timeframe
    List<(String, bool, List<List<MealsAndSymptoms>>)> symptomsMealsInTimeList = [];
    for(var symptom in listeVorkommen.entries){
      List<List<MealsAndSymptoms>> afterThisSymptom = [];

      for(var occurance in symptom.value){
        List<MealsAndSymptoms> subList = [];

        for(var entry in finalTable){
        // Go through all occurances of symptom
          DateTime inTimeFrame = occurance.subtract(Duration(hours: timeframe));
          
          // if in time frame, add
          if(entry.dateTime.isAfter(inTimeFrame) && entry.dateTime.isBefore(occurance) && !entry.isSymptom){
            subList.add(entry);
            entry.leadToSymptom = true; // mark as it made symptom occur
          }
        }
        afterThisSymptom.add(subList);
      }

      if(summedView){
        if(selectedSymptoms.map((a) => a.text).toList().contains(symptom.key)){ // TODO: klappt nicht (mehr) --> ausgebaut mit anderer summedView
          // only add if symptom is selected
          symptomsMealsInTimeList.add((symptom.key, true, afterThisSymptom));  
        }
        else{
          symptomsMealsInTimeList.add((symptom.key, false, afterThisSymptom));  
        }
      }
      else{
        // TODO: double check, frisch eingebaut
        if(typicalIntoleranceSymptoms){
          if(selectedSymptoms.map((a) => a.text).toList().contains(symptom.key)){ 
            symptomsMealsInTimeList.add((symptom.key, true, afterThisSymptom));
          }
        }
        else{
          symptomsMealsInTimeList.add((symptom.key, true, afterThisSymptom));
        }
      }
    }  

    // calculate columnwiths
    List<double> colWidths = [
      measureWidthOfValue("Symptom", context),
      measureWidthOfValue("Fruktose", context),
      measureWidthOfValue("Laktose", context),
      measureWidthOfValue("Sorbit", context),
      measureWidthOfValue("Gluten", context),
    ];

    // counters for summedView (normal case))
    int countTotalSymptomOccurances = 0;
    int countTotalHighFructose = 0;
    int countTotalHighLactose = 0;
    int countTotalHighSorbitol = 0;
    int countTotalGluten = 0;

    // counters for summedView (shift, if not all Symptoms considered)
    int overallHighFructose = 0;
    int overallHighLactose = 0;
    int overallHighSorbitol = 0;
    int overallGluten = 0;

    // Go through list and count how often threshold of allergens exceeded
    final List<DataRow> rows = [];
    for(var symptomOccurances in symptomsMealsInTimeList){

      // update colWidth (only first column)
      if(colWidths[0] < measureWidthOfValue(symptomOccurances.$1, context)){
        colWidths[0] = measureWidthOfValue(symptomOccurances.$1, context);
      }

      // Add some padding (only minimal to allow correct display of text)
      for(int i = 0; i < colWidths.length; i++){
        colWidths[i] += 2;
      }

      // count over thresholds
      int occuranceCount = 0;
      int highFructose = 0;
      int highLactose = 0;
      int highSorbitol = 0;
      int countGluten = 0;

      // fill occurance count
      for(var e in listeVorkommen.entries){
        if(e.key == symptomOccurances.$1){
          occuranceCount = e.value.length;
          if(symptomOccurances.$2){
            countTotalSymptomOccurances += e.value.length;
          }
        }
      }

      // Logic for summing meals  
      for(var meals in symptomOccurances.$3){
        double fructose = 0;
        double lactose = 0;
        double sorbitol = 0;
        GlutenAmount gluten = GlutenAmount.GLUTEN_FREE;

        for(var m in meals){
          fructose += m.fructose ?? 0;
          lactose += m.lactose ?? 0;
          sorbitol += m.sorbitol ?? 0;
          gluten = (m.gluten == GlutenAmount.CONTAINS_GLUTEN || gluten == GlutenAmount.CONTAINS_GLUTEN 
                                ? GlutenAmount.CONTAINS_GLUTEN 
                                : (m.gluten == GlutenAmount.CONTAINS_TRACES || gluten == GlutenAmount.CONTAINS_TRACES
                                      ? GlutenAmount.CONTAINS_TRACES
                                      : gluten
                                  )
                    );
        }

        if(fructose >= (num.tryParse((controllerFructose.text == "" ? "0" : controllerFructose.text).trim().toString().replaceAll(",", ".").replaceAll(" ", "")) ?? (fructose + 1))){ // If controller == null, then make if clause impossible //TODO: sollte nun nicht mehr eintreten (mit regex, bzw hier == "")
          if(symptomOccurances.$2){
            overallHighFructose++;
          }
          highFructose++;
          countTotalHighFructose++;

          
          for(var f in finalTable){
            if(meals.contains(f)){
              f.leadToSymptom = true; // mark as it made symptom occur
            }
          }
          
        }

        if(lactose >= (num.tryParse((controllerLactose.text == "" ? "0" : controllerLactose.text).trim().toString().replaceAll(",", ".").replaceAll(" ", "")) ?? (lactose + 1))){ // If controller == null, then make if clause impossible
          
          if(symptomOccurances.$2){
            overallHighLactose++;
          }
          highLactose++;
          countTotalHighLactose++;

          for(var f in finalTable){
            if(meals.contains(f)){
              f.leadToSymptom = true; // mark as it made symptom occur
            }
          }
        }

        if(sorbitol >= (num.tryParse((controllerSorbitol.text == "" ? "0" : controllerSorbitol.text).trim().toString().replaceAll(",", ".").replaceAll(" ", "")) ?? (sorbitol + 1))){ // If controller == null, then make if clause impossible
          if(symptomOccurances.$2){
            overallHighSorbitol++;
          }
          highSorbitol++;
          countTotalHighSorbitol++;

          for(var f in finalTable){
            if(meals.contains(f)){
              f.leadToSymptom = true; // mark as it made symptom occur
            }
          }
        }

        // if contains gluten, always count
        if(gluten == GlutenAmount.CONTAINS_GLUTEN){
          if(symptomOccurances.$2){
            overallGluten++;
          }
          countGluten++;
          countTotalGluten++;

          for(var f in finalTable){
            if(meals.contains(f)){
              f.leadToSymptom = true; // mark as it made symptom occur
            }
          }
        }

        // if checkbox activated: also increase if traces included
        if(glutenWithTraces ? gluten == GlutenAmount.CONTAINS_TRACES : false){
          if(symptomOccurances.$2){
            overallGluten++;
          }
          countGluten++;
          countTotalGluten++;

          for(var f in finalTable){
            if(meals.contains(f)){
              f.leadToSymptom = true; // mark as it made symptom occur
            }
          }
        }
      }

      if(!summedView){
        // add row to table
        rows.add(DataRow(
          cells: [
            DataCell(SizedBox(width: colWidths[0], child: Text(symptomOccurances.$1))),
            DataCell(SizedBox(width: colWidths[1], child: Text(timeframe > 0 ? "$highFructose/$occuranceCount" : "-", style: TextStyle(color: ((highFructose == occuranceCount) && highFructose != 0 )? Colors.red : null),))),
            DataCell(SizedBox(width: colWidths[2], child: Text(timeframe > 0 ? "$highLactose/$occuranceCount" : "-", style: TextStyle(color: ((highLactose == occuranceCount) && highLactose != 0 )? Colors.red : null),))),
            DataCell(SizedBox(width: colWidths[3], child: Text(timeframe > 0 ? "$highSorbitol/$occuranceCount" : "-", style: TextStyle(color: ((highSorbitol == occuranceCount) && highSorbitol != 0 )? Colors.red : null),))),
            DataCell(SizedBox(width: colWidths[4], child: Text(timeframe > 0 ? "$countGluten/$occuranceCount" : "-", style: TextStyle(color: ((countGluten == occuranceCount) && countGluten != 0 )? Colors.red : null),))),
          ]
        ));
      }
    }

    // for summedView, first calculate how often allergens were eaten and did not lead to symptoms
    // this function returns a list of clusters for the given timeframe, already cleaned out data that lead to symptoms, parse it to see how often allergens were eaten without symptoms
    List<List<MealsAndSymptoms>> mealsEatenWithoutSymptoms = clusterMealsWithoutSymptoms(finalTable, timeframe);

    int countHighFructoseWithoutSymptoms = 0;
    int countHighLactoseWithoutSymptoms = 0;
    int countHighSorbitolWithoutSymptoms = 0;
    int countGlutenWithoutSymptoms = 0;

    for(var cluster in mealsEatenWithoutSymptoms){

      double localFructoseCount = 0;
      double localLactoseCount = 0;
      double localSorbitolCount = 0;
      GlutenAmount localGluten = GlutenAmount.GLUTEN_FREE;

      for(var c in cluster){
        localFructoseCount += c.fructose ?? 0;
        localLactoseCount += c.lactose ?? 0;
        localSorbitolCount += c.sorbitol ?? 0;
        localGluten = (c.gluten == GlutenAmount.CONTAINS_GLUTEN || localGluten == GlutenAmount.CONTAINS_GLUTEN 
                                ? GlutenAmount.CONTAINS_GLUTEN 
                                : (c.gluten == GlutenAmount.CONTAINS_TRACES || localGluten == GlutenAmount.CONTAINS_TRACES
                                      ? GlutenAmount.CONTAINS_TRACES
                                      : localGluten
                                  )
                    );
      }

      if(localFructoseCount >= (num.tryParse((controllerFructose.text == "" ? "0" : controllerFructose.text).trim().toString().replaceAll(",", ".").replaceAll(" ", "")) ?? (localFructoseCount + 1))){
        countHighFructoseWithoutSymptoms++;
      }
      if(localLactoseCount >= (num.tryParse((controllerLactose.text == "" ? "0" : controllerLactose.text).trim().toString().replaceAll(",", ".").replaceAll(" ", "")) ?? (localLactoseCount + 1))){
        countHighLactoseWithoutSymptoms++;
      }
      if(localSorbitolCount >= (num.tryParse((controllerSorbitol.text == "" ? "0" : controllerSorbitol.text).trim().toString().replaceAll(",", ".").replaceAll(" ", "")) ?? (localSorbitolCount + 1))){
        countHighSorbitolWithoutSymptoms++;
      }
      // if contains gluten, always count
      if(localGluten == GlutenAmount.CONTAINS_GLUTEN){
        countGlutenWithoutSymptoms++;
      }

      // if checkbox activated: also increase if traces included
      if((glutenWithTraces ? (localGluten == GlutenAmount.CONTAINS_TRACES) : false)){
        countGlutenWithoutSymptoms++;
      }
    }

//TODO: remove
    /*if(summedView){
      // add row for eaten and got symptoms
      rows.add(DataRow(
        cells: [
          DataCell(SizedBox(width: colWidths[0], child: Text("Erhöht/Symptom"))),
          DataCell(SizedBox(width: colWidths[1], child: Text(timeframe > 0 ? "$overallHighFructose/$countTotalSymptomOccurances" : "-", style: TextStyle(color: ((overallHighFructose == countTotalSymptomOccurances) && overallHighFructose != 0 )? Colors.red : null),))),
          DataCell(SizedBox(width: colWidths[2], child: Text(timeframe > 0 ? "$overallHighLactose/$countTotalSymptomOccurances" : "-", style: TextStyle(color: ((overallHighLactose == countTotalSymptomOccurances) && overallHighLactose != 0 )? Colors.red : null),))),
          DataCell(SizedBox(width: colWidths[3], child: Text(timeframe > 0 ? "$overallHighSorbitol/$countTotalSymptomOccurances" : "-", style: TextStyle(color: ((overallHighSorbitol == countTotalSymptomOccurances) && overallHighSorbitol != 0 )? Colors.red : null),))),
          DataCell(SizedBox(width: colWidths[4], child: Text(timeframe > 0 ? "$overallGluten/$countTotalSymptomOccurances" : "-", style: TextStyle(color: ((overallGluten == countTotalSymptomOccurances) && overallGluten != 0 )? Colors.red : null),))),
        ]
      ));
      rows.add(DataRow(
        cells: [
          DataCell(SizedBox(width: colWidths[0], child: Text("Symptomfrei/Erhöht"))),
          DataCell(SizedBox(width: colWidths[1], child: Text(timeframe > 0 ? "$countHighFructoseWithoutSymptoms/${countHighFructoseWithoutSymptoms + countTotalHighFructose}" : "-", style: TextStyle(color: ((countTotalHighFructose == 0) && countHighFructoseWithoutSymptoms != 0 )? Colors.green : null),))),
          DataCell(SizedBox(width: colWidths[2], child: Text(timeframe > 0 ? "$countHighLactoseWithoutSymptoms/${countHighLactoseWithoutSymptoms + countTotalHighLactose}" : "-", style: TextStyle(color: ((countTotalHighLactose == 0) && countHighLactoseWithoutSymptoms != 0 )? Colors.green : null),))),
          DataCell(SizedBox(width: colWidths[3], child: Text(timeframe > 0 ? "$countHighSorbitolWithoutSymptoms/${countHighSorbitolWithoutSymptoms + countTotalHighSorbitol}" : "-", style: TextStyle(color: ((countTotalHighSorbitol == 0) && countHighSorbitolWithoutSymptoms != 0 )? Colors.green : null),))),
          DataCell(SizedBox(width: colWidths[4], child: Text(timeframe > 0 ? "$countGlutenWithoutSymptoms/${countGlutenWithoutSymptoms + countTotalGluten}" : "-", style: TextStyle(color: ((countTotalGluten == 0) && countGlutenWithoutSymptoms != 0 )? Colors.green : null),))),
        ]
      ));
    }*/

    //TODO: TEST
    List<(String, int, int)> barData = [];
    if(timeframe > 0){
      barData = [
        ("Fruktose", 
          // catch if no match, then fill with 1 (100% without symptom)
          (countHighFructoseWithoutSymptoms + countTotalHighFructose) == 0 
                ? 1
                : countHighFructoseWithoutSymptoms, 
          // catch if 0, otherwise error when trying to divide by 0 laters
          ((countHighFructoseWithoutSymptoms + countTotalHighFructose) == 0 
                ? 1 
                : (countHighFructoseWithoutSymptoms + countTotalHighFructose))),

        ("Laktose", 
          // catch if no match, then fill with 1 (100% without symptom)
          (countHighLactoseWithoutSymptoms + countTotalHighLactose) == 0 
                ? 1 
                : countHighLactoseWithoutSymptoms, 
          // catch if 0, otherwise error when trying to divide by 0 laters
          ((countHighLactoseWithoutSymptoms + countTotalHighLactose) == 0 
              ? 1 
              : (countHighLactoseWithoutSymptoms + countTotalHighLactose))),

        ("Sorbitol", 
          // catch if no match, then fill with 1 (100% without symptom)
          (countHighSorbitolWithoutSymptoms + countTotalHighSorbitol) == 0 
                ? 1 
                : countHighSorbitolWithoutSymptoms, 
          // catch if 0, otherwise error when trying to divide by 0 laters
          ((countHighSorbitolWithoutSymptoms + countTotalHighSorbitol) == 0 
              ? 1 
              : (countHighSorbitolWithoutSymptoms + countTotalHighSorbitol))),

        ("Gluten", 
          // catch if no match, then fill with 1 (100% without symptom)
          (countGlutenWithoutSymptoms + countTotalGluten) == 0 
                ? 1 
                : countGlutenWithoutSymptoms, 
          // catch if 0, otherwise error when trying to divide by 0 laters
          ((countGlutenWithoutSymptoms + countTotalGluten) == 0 
              ? 1 
              : (countGlutenWithoutSymptoms + countTotalGluten))),
      ];
    }
  
    // For filtering of meals and symptoms table, upload nutritional clusters (with and without symptoms)
    updateAllClusters([...mealsEatenWithoutSymptoms, ...symptomsMealsInTimeList.expand((e) => e.$3)]);

    // fullScreenView
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              summedView
                  ? SizedBox(width: 0, height: 0,)
                  : SizedBox(
                      height: 70,
                      width: 200,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Nur ausgewählte\nSymptome anzeigen?",
                              style: TextStyle(fontSize: 13),
                              textAlign: TextAlign.center,
                            ),
                            Checkbox(
                              value: typicalIntoleranceSymptoms, 
                              onChanged: (bool? value){
                                setState(() {
                                  typicalIntoleranceSymptoms = value ?? false;
                                });
                              },
                              splashRadius: Theme.of(context).checkboxTheme.splashRadius,
                              shape: Theme.of(context).checkboxTheme.shape,
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                            ),
                          ],
                        ),
                      ),
                    ),

              summedView 
                  ? SizedBox(width: 0, height: 0,)
                  : Center(
                      child: SizedBox(
                        height: 50,
                        width: 300,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: callTimeframeSelector(summedView))
                      ),
                    ),
              SizedBox(
                height: 50,
                width: summedView ? 80 : 100,
                child: Center(
                  child: TextField(
                    controller: controllerFructose,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*[.,]?\d*$'),  // Regex to allow numbers, with a dot or comma inbetween
                      )
                    ],
                    decoration: InputDecoration(
                      labelText: "Fruktose",
                      isDense: true,
                      contentPadding: EdgeInsets.all(5),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide())
                    ),
                    onChanged: (_) => setState(() {refreshDiagram++;}),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                width: summedView ? 80 : 100,
                child: Center(
                  child: TextField(
                    controller: controllerLactose,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*[.,]?\d*$'),  // Regex to allow numbers, with a dot or comma inbetween
                      )
                    ],
                    decoration: InputDecoration(
                      labelText: "Laktose",
                      isDense: true,
                      contentPadding: EdgeInsets.all(5),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide())
                    ),
                    onChanged: (_) => setState(() {refreshDiagram++;}),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                width: summedView ? 80 : 100,
                child: Center(
                  child: TextField(
                    controller: controllerSorbitol,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*[.,]?\d*$'),  // Regex to allow numbers, with a dot or comma inbetween
                      )
                    ],
                    decoration: InputDecoration(
                      labelText: "Sorbit",
                      isDense: true,
                      contentPadding: EdgeInsets.all(5),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide())
                    ),
                    onChanged: (_) => setState(() {refreshDiagram++;}),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                width: 120,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Gluten mit Spuren?",
                        style: TextStyle(fontSize: 13),
                        textAlign: TextAlign.center,
                      ),
                      Checkbox(
                        value: glutenWithTraces, 
                        onChanged: (bool? value){
                          summedView ? setGlutenWithTraces(value ?? false, false) : setGlutenWithTraces(value ?? false, true);
                        },
                        splashRadius: Theme.of(context).checkboxTheme.splashRadius,
                        shape: Theme.of(context).checkboxTheme.shape,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                      ),
                    ],
                  ),
                ),
              )
            ]
          ),
          
          summedView ? SizedBox(height: 0, width: 0,) : SizedBox(height: 20,),  // Space between rows
    
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                timeframe == 0 ? (summedView ? "" : "Bitte ein Zeitfenster auswählen") : "Berücksichtigung von Mahlzeiten $timeframe Stunden vor Symptom",
                style: TextStyle(
                  fontWeight: timeframe == 0 ? FontWeight.bold : null,
                  color: timeframe == 0 ? Colors.red : null
                ),
              ),
            ],
          ),
    
          // Here is the table with information
          Expanded(
            child: summedView 
            ? BarDiagram(
              key: ValueKey(refreshDiagram),
              barData: barData)
            : Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      columnSpacing: 5,
                      columns: [
                        DataColumn(label: SizedBox(width: colWidths[0], child: summedView ? Text("") : Text("Symptom")),),
                        DataColumn(label: SizedBox(width: colWidths[1], child: Text("Fruktose")),),
                        DataColumn(label: SizedBox(width: colWidths[2], child: Text("Laktose")),),
                        DataColumn(label: SizedBox(width: colWidths[3], child: Text("Sorbit")),),
                        DataColumn(label: SizedBox(width: colWidths[4], child: Text("Gluten")),),
                      ], 
                      rows: rows)
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}