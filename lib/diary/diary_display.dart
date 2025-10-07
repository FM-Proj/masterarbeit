import 'package:dietitian_dashboard/diary/Widgets/CountSymptoms.dart';
import 'package:dietitian_dashboard/diary/Widgets/allergenSymptomTable.dart';
import 'package:dietitian_dashboard/diary/Widgets/patientInformation.dart';
import 'package:dietitian_dashboard/diary/Widgets/quickOverview.dart';
import 'package:dietitian_dashboard/diary/Widgets/saveDataInBrowser.dart';
import 'package:flutter/material.dart';
import 'package:dietitian_dashboard/meals/meal_cubit.dart';
import 'package:dietitian_dashboard/symptom_reports/symptom_reports_cubit.dart';
import 'package:intl/intl.dart';
import 'package:viatolea_api/api.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

// Widgets (saved in own .dart files)
import 'package:dietitian_dashboard/diary/Widgets/symptomSelector.dart';
import 'package:dietitian_dashboard/diary/Widgets/timeframeSelector.dart';
import 'package:dietitian_dashboard/diary/Widgets/dateSelector.dart';
import 'package:dietitian_dashboard/diary/Widgets/mealAndSymptomTable.dart';



// Stateful to allow changes while App usage
class DiaryDisplay extends StatefulWidget {
  final MealLoaded mealState;
  final SymptomReportsLoaded symptomReportsState;

  const DiaryDisplay({
    super.key,
    required this.mealState,
    required this.symptomReportsState,
  });

  @override
  State<DiaryDisplay> createState() => _DiaryDisplayState();
}

class _DiaryDisplayState extends State<DiaryDisplay>{  

  // create setStates for childWidgets
  void updateTimeframe(int? newValue){
    setState(() {
      durationTimeframe = newValue;
    });
    updateTable();
  }

  void updateCalender(DateTime? start, DateTime? end){
    setState(() {
      startDate = start;
      endDate = end;
    });
    updateTable();
    setSymptomControllerItems();
  }

  void updateTable(){
    _createFinalTable(durationTimeframe, showFructoseClusters);
    setState(() {
      forceUpdate++;
    });
  }

  void changeNutritionalValue(List<SaveMealComponentsInBrowser> newValue, BuildContext context, bool fullScreen){
    setState(() {
      // save changes
      saveUpdatedTableInBrowser(newValue);
  });
    updateTable();
    if(fullScreen){
      Navigator.pop(context);
      fullscreenTableMealsAndSymptoms(context);
    }
  }

  void setGlutenWithTraces(bool value, bool summedView){
    setState(() {
      glutenWithTraces = value;
    });
    updateTable();
    if(summedView){
      Navigator.pop(context);
      fullscreenTableAllergensAndSymptoms(context);
    }
  }

  void updateAllergenSymptomTable(int? newValue){
    Navigator.pop(context);
    updateTimeframe(newValue);
    fullscreenTableAllergensAndSymptoms(context);
  }

  void updateAllClusters (List<List<MealsAndSymptoms>> clusters) { // TODO
    clustersInTimeframe = clusters;
    _createFinalTable(durationTimeframe, showFructoseClusters);
  }
  

//TODO: update that only symptoms that are in table (between start&end) can be selected
  void updateSelectedSymptoms(List<MealsAndSymptoms> newSelectedSymptoms){
    setState(() {
      selectedSymptoms = newSelectedSymptoms;
    });
    updateTable();
  }

  void filterTable(String changed){
    switch(changed){
      case "Fructose": showFructoseClusters = !showFructoseClusters;
      case "Sorbitol": showSorbitolClusters = !showSorbitolClusters;
      case "Lactose": showLactoseClusters = !showLactoseClusters;
      case "Gluten": showGlutenClusters = !showGlutenClusters;
      case _: null; // can never take place
    }
    updateTable();
    // because only called from fullscreen -> force a reload
    Navigator.pop(context);
    fullscreenTableMealsAndSymptoms(context);
  }

  // update Symptomcontroller items
  void setSymptomControllerItems(){
   // List with all Symptoms
    List<MealsAndSymptoms> allSymptoms = [];
    
    // Only save each Symptom (name) once
    for(var entry in finalTable){
      // set bool to false
      bool notInList = true;

      if(entry.isSymptom && entry.dateTime.isAfter(DateTime(startDate!.year, startDate!.month, startDate!.day)) && entry.dateTime.isBefore(DateTime(endDate!.year, endDate!.month, endDate!.day).add(Duration(days: 1)))){
        for(var e in allSymptoms){
          if(e.text == entry.text){
            notInList = false;
          }
        }

        if(notInList){
          allSymptoms.add(entry);
        }
      }
    }

    // update state --> display correct values in symptom selector
    setState(() {
      dropdownSymptomOptions.clear();
      for(var entry in allSymptoms){
        dropdownSymptomOptions.add(DropdownItem<MealsAndSymptoms>(
          value: entry,
          label: entry.text,
          ),
        );
      }
      // push items to controller
      symptomController.setItems(dropdownSymptomOptions);
    });
  }

  String makeDisplayedText(DateTime? start, DateTime? end){
    displayedText = "${DateFormat('dd.MM.yy').format(startDate!)} bis ${DateFormat('dd.MM.yy').format(endDate!)}";

    return displayedText!;
  }

  Widget callTimeframeSelector(bool summedView){
    if(summedView){
      return TimeframeSelector(finalTable: finalTable, durationTimeframe: durationTimeframe, updateTimeframe: updateTimeframe);
    } else{
      return TimeframeSelector(finalTable: finalTable, durationTimeframe: durationTimeframe, updateTimeframe: updateAllergenSymptomTable);
    }
  }
  
  // for updating table
  int forceUpdate = 0;

  // joint Table
  List<MealsAndSymptoms> finalTable = [];

  // Value for timeframe duration selector
  int? durationTimeframe;

  // Set start and end date for date selector
  DateTime? startDate;
  DateTime? endDate;

  // displayedText in Calender field
  String? displayedText;
  String? displayedDuration;

  // Pop-up Calender - List filled in initState
  List<DateTime> symptomDays = [];
  List<DateTime> allDatesLogged = [];

  // Value for selection of multiple symptoms
  final List<DropdownItem<MealsAndSymptoms>> dropdownSymptomOptions = [];
  List<MealsAndSymptoms> selectedSymptoms = []; 
  final MultiSelectController<MealsAndSymptoms> symptomController = MultiSelectController();

  // load mealState and symptomReportsState
  late MealLoaded mealState;
  late SymptomReportsLoaded symptomReportsState;

  // set toggleDensity to true as start (shows full info)
  bool toggleDensity = true;

  // Controllers for being able to change threshold of allergens
  late final TextEditingController controllerFructose;
  late final TextEditingController controllerLactose;
  late final TextEditingController controllerSorbitol;
  late bool glutenWithTraces;

  // List of allergy candidates
  late List<MealsAndSymptoms> allergyCandidates;

  // List of all clusters in timeframe
  late List<List<MealsAndSymptoms>> clustersInTimeframe;

  // bools for filtering meal and symptom table
  late bool showFructoseClusters;
  late bool showLactoseClusters;
  late bool showSorbitolClusters;
  late bool showGlutenClusters;

  // Initial state
  @override
  void initState(){
    super.initState();
    mealState = widget.mealState;
    symptomReportsState = widget.symptomReportsState;

    // initialize controllers
    controllerFructose = TextEditingController(text: "5")..addListener(() => setState(() {}));
    controllerLactose = TextEditingController(text: "5")..addListener(() => setState(() {}));
    controllerSorbitol = TextEditingController(text: "0,5")..addListener(() => setState(() {}));
    glutenWithTraces = false;

    // initiaalize filter bools
    showFructoseClusters = false;
    showLactoseClusters = false;
    showSorbitolClusters = false;
    showGlutenClusters = false;

    // Fill List with all Symptom days, needed for calender
    for(var entry in symptomReportsState.symptomReports){
      if(!symptomDays.contains(DateTime(entry.dateTime.toLocal().year, entry.dateTime.toLocal().month, entry.dateTime.toLocal().day))){
        symptomDays.add(DateTime(entry.dateTime.toLocal().year, entry.dateTime.toLocal().month, entry.dateTime.toLocal().day));
      }
    }
    // Sort List
    symptomDays.sort((a, b) => a.compareTo(b));

    // For the calender, fill all dates on which user entered data (Symptoms and Meals)
    // cast to DateTime(entry.dateTime.year, entry.dateTime.month, entry.dateTime.day) to remove time stamps for comparison
    for(var entry in symptomReportsState.symptomReports){
      if(!allDatesLogged.contains(DateTime(entry.dateTime.toLocal().year, entry.dateTime.toLocal().month, entry.dateTime.toLocal().day))){
        allDatesLogged.add(DateTime(entry.dateTime.toLocal().year, entry.dateTime.toLocal().month, entry.dateTime.toLocal().day));
      }
    }
    for(var entry in mealState.meals){
      if(!allDatesLogged.contains(DateTime(entry.dateTime.toLocal().year, entry.dateTime.toLocal().month, entry.dateTime.toLocal().day))){
        allDatesLogged.add(DateTime(entry.dateTime.toLocal().year, entry.dateTime.toLocal().month, entry.dateTime.toLocal().day));
      }
    }
    // Sort List
    allDatesLogged.sort((a, b) => a.compareTo(b));

    // Set start&enddate of calender
    startDate ??= allDatesLogged[0];
    DateTime now = DateTime.now();
    endDate ??= DateTime(now.year, now.month, now.day);

    // fill clusters in timeframe (initially)
    clustersInTimeframe = [];

    // create initial Table
    _createFinalTable(null, showFructoseClusters);

    // set calender field
    displayedText = null;
    displayedDuration = null;

    //fill allergyCandidates
    allergyCandidates = [];
    for(var e in finalTable){
      if(e.allergyCandidate ?? false){
        if(!allergyCandidates.map((a) => a.text).toList().contains(e.text)){
          allergyCandidates.add(e);
        }
      }
    }

    // as a standard, select 8 hours for timeframe
    durationTimeframe = 8;

    // set symptom selector options
    setSymptomControllerItems();

    // create initial Table (with initial timeframe)
    _createFinalTable(durationTimeframe, showFructoseClusters);
  }

  // Create Map to count occurances of each symptom
  Map<String, int> occuranceCounterSymptoms(DateTime filterStartDate, DateTime filterEndDate){
    final Map<String, int> counterSymptoms = {};

    for(var value in symptomReportsState.symptomReports){
      final key = value.symptom;

      // check if symptom is in filter for date
      if((value.dateTime.toLocal().isBefore(filterEndDate) && value.dateTime.toLocal().isAfter(filterStartDate)) || (value.dateTime.toLocal().isAtSameMomentAs(filterStartDate)) || (value.dateTime.toLocal().isAtSameMomentAs(filterEndDate))){
        // If already occured, then increment counter
        if(counterSymptoms.containsKey(key)){
          counterSymptoms[key] = counterSymptoms[key]! + 1;
        }
        // If not occured yet, set counter to 1
        else{
          counterSymptoms[key] = 1;
        }
      }
    }

    return counterSymptoms;
  }
  

  @override
  Widget build(BuildContext context) {
    //Dashboard
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      
      //Row is the entire screen as a row
      body: Row(
        children: [
          // The two expanded build up the first division of the screen: The first is the left Column, the second the right one
          // First column should be a bit bigger, so set to flex 3/5
          Expanded(
            flex: 3,

            // This container holds the left sides boxes (TODO: name them)
            child: Container(
             
             // create a column to hold the rows
              child: Column(

                // These make up the three Rows --> each one in expanded
                children: [
                  // Set flex to 1/6
                  Expanded(
                    flex: 1,
                    child: Container(

                      //Create Row to hold two columns (top two widgets: Zeitraum and Zeitfenster)
                      child: Row(

                        // First child: Zeitraum, second child: Zeitfenster
                        children: [
                          // Frame for the Widget: Zeitraum
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),

                              child: Container(
                                // Set round corners and color to Theme
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow:[
                                    BoxShadow(
                                      color: Theme.of(context).shadowColor,
                                      blurRadius: 6,
                                      offset: Offset(0, 3)
                                    )
                                  ],
                                ),

                                // Content of Box: Zeitraum
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Zeitraum",
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(child: DateSelector(
                                          key: ValueKey(forceUpdate),   // added key to refresh widgets
                                          allDatesLogged: allDatesLogged, 
                                          symptomDays: symptomDays, 
                                          updateCalender: updateCalender,
                                          makeDisplayedText: makeDisplayedText,)),
                                        IconButton(
                                          style: Theme.of(context).iconButtonTheme.style,
                                          tooltip: "Eingabe entfernen\n(Gesamten Zeitraum anzeigen)",
                                          onPressed: () {
                                            setState(() {
                                              startDate = allDatesLogged[0];
                                              DateTime now = DateTime.now();
                                              endDate = DateTime(now.year, now.month, now.day);
                                            });
                                            updateCalender(startDate, endDate);
                                          },
                                          icon: Icon(Icons.refresh)
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ),

                          // Frame for the Widget: Zeitfenster
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                // Set Decoration of Box itself
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow:[
                                    BoxShadow(
                                      color: Theme.of(context).shadowColor,
                                      blurRadius: 6,
                                      offset: Offset(0, 3)
                                    )
                                  ],
                                ),

                                // Content of Box: Zeitfenster
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Zeitfenster",
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    TimeframeSelector(
                                      key: ValueKey(forceUpdate),
                                      finalTable: finalTable, 
                                      durationTimeframe: durationTimeframe, 
                                      updateTimeframe: updateTimeframe,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ),
                        ],
                      ),
                    )
                  ),

                  // Set flex to 2/6
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow:[
                                    BoxShadow(
                                      color: Theme.of(context).shadowColor,
                                      blurRadius: 6,
                                      offset: Offset(0, 3)
                                    )
                                  ],
                                ),

                                //TODO quick overview
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: QuickOverview(
                                        key: ValueKey(forceUpdate),
                                        finalTable: finalTable,
                                        startDate: startDate,
                                        endDate: endDate,
                                        timeframe: durationTimeframe,
                                        selectedSymptoms: selectedSymptoms,
                                        controllerFructose: controllerFructose,
                                        controllerLactose: controllerLactose,
                                        controllerSorbitol: controllerSorbitol,
                                        glutenWithTraces: glutenWithTraces,
                                      )
                                    ),
                                  ],
                                ),
                              )
                            )
                          ),

                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow:[
                                    BoxShadow(
                                      color: Theme.of(context).shadowColor,
                                      blurRadius: 6,
                                      offset: Offset(0, 3)
                                    )
                                  ],
                                ),

                                // Symptom counter widget
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: CountSymptoms(
                                        key: ValueKey(forceUpdate),   // added key to refresh widgets
                                        finalTable: finalTable, 
                                        startDate: startDate, 
                                        endDate: endDate,),
                                    ),
                                  ],
                                ),

                              )
                            )
                          )
                        ],
                      ), //TODO
                    )
                  ),

                  // Set flex to 3/6 --> Table should be bigger
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(

                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow:[
                            BoxShadow(
                              color: Theme.of(context).shadowColor,
                              blurRadius: 6,
                              offset: Offset(0, 3)
                            )
                          ],
                        ),

                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(5.0), //TODO
                            
                              // Table (bottom left)
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  return MealAndSymptomDisplay(
                                    key: ValueKey(forceUpdate),   // added key to refresh widgets
                                    constraints: constraints, 
                                    filterTimeframe: durationTimeframe, 
                                    showAllColumns: false,  
                                    finalTable: finalTable, 
                                    endDate: endDate, 
                                    startDate: startDate, 
                                    toggleDensity: toggleDensity,
                                    updateNutritionalValues: changeNutritionalValue,
                                    //TODO updateFinalTable: updateFinalTable,
                                    filterTable: filterTable,
                                    showFructose: showFructoseClusters,
                                    showLactose: showLactoseClusters,
                                    showSorbitol: showSorbitolClusters,
                                    showGluten: showGlutenClusters,
                                  );
                                }
                              ),
                            ),
                        
                            // Icons for full screen mode & toggleDensity in top right corner of box
                            Align(
                              alignment: Alignment.topRight,
                              child: Row(
                                // keep row as small as possible
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    style: Theme.of(context).iconButtonTheme.style,
                                    onPressed: () {
                                      setState(() {
                                        toggleDensity = !toggleDensity;
                                      });
                                      updateTable();
                                    },
                                    tooltip: toggleDensity ? "Mahlzeiten komprimieren" : "Mahlzeiten komplett anzeigen",
                                    icon: toggleDensity ? Icon(Icons.compress) : Icon(Icons.expand)
                                  ),

                                  IconButton(
                                    style: Theme.of(context).iconButtonTheme.style,
                                    onPressed: () => fullscreenTableMealsAndSymptoms(context),
                                    tooltip: "Tabelle vergrößern",
                                    icon: Icon(Icons.fullscreen),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //Second column a bit smaller, so set flex to 2/5
          // TODO: (???) // This is the entire right side of the Dashboard (symptome, ???)
          Expanded(
            flex: 2,

            // This container holds the right sides boxes (TODO: name them)
            child: Container(

              // TODO: right side
              child: Column(

                children: [
                  Expanded(
                    flex: 1,

                    child: Container(

                      //TODO:  Row containing right side top two Elements
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),

                              child: Container(
                                // Set round corners and color to Theme
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow:[
                                    BoxShadow(
                                      color: Theme.of(context).shadowColor,
                                      blurRadius: 6,
                                      offset: Offset(0, 3)
                                    )
                                  ],
                                ),

                                // Content of Box: Zeitraum
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Symptome",
                                        style: Theme.of(context).textTheme.titleMedium,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: SymptomSelector(
                                            finalTable: finalTable, 
                                            symptomController: symptomController, 
                                            updateSelectedSymptoms: updateSelectedSymptoms,
                                            dropdownSymptomOptions: dropdownSymptomOptions,
                                          )
                                        ),
                                        IconButton(
                                          style: Theme.of(context).iconButtonTheme.style,
                                          tooltip: "Alle typischen Unverträglichkeitssymptome auswählen",
                                          onPressed: () {
                                            symptomController.selectWhere((a){
                                              return a.value.intoleranceCandidate ?? false;
                                            });
                                          },
                                          icon: Icon(Icons.select_all)
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ),

                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow:[
                                          BoxShadow(
                                            color: Theme.of(context).shadowColor,
                                            blurRadius: 6,
                                            offset: Offset(0, 3)
                                          )
                                        ],
                                      ),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: WidgetStateColor.transparent,
                                          shadowColor: WidgetStateColor.transparent,
                                        ),
                                        onPressed: () {
                                          durationTimeframe = null;
                                      
                                          // Set start and end date for date selector
                                          startDate = allDatesLogged[0];
                                          DateTime now = DateTime.now();
                                          endDate = DateTime(now.year, now.month, now.day);
                                      
                                          // Value for selection of multiple symptoms
                                          symptomController.unselectWhere((a) => true);

                                          // reset bools
                                          toggleDensity = true;
                                          glutenWithTraces = false;

                                          // reset controllers for allergens
                                          controllerFructose.text = "5";
                                          controllerLactose.text = "5";
                                          controllerSorbitol.text = "0,5";

                                          // reset show bools
                                          showFructoseClusters = false;
                                          showGlutenClusters = false;
                                          showLactoseClusters = false;
                                          showSorbitolClusters = false;
                                
                                          updateCalender(startDate, endDate);
                                          updateTimeframe(null);
                                          updateTable();
                                        },
                                        
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Reset",
                                              style: TextStyle(
                                                color: Theme.of(context).primaryColor
                                              ),
                                            ),
                                            Icon(Icons.undo)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow:[
                                          BoxShadow(
                                            color: Theme.of(context).shadowColor,
                                            blurRadius: 6,
                                            offset: Offset(0, 3)
                                          )
                                        ],
                                      ),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: WidgetStateColor.transparent,
                                          shadowColor: WidgetStateColor.transparent,
                                        ),
                                        onPressed: () => showPopUpPatientInfo(context, /*TODO authenticationUserId:*/ "123", finalTable),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Patient",
                                              style: TextStyle(
                                                //fontWeight: FontWeight.bold, //TODO
                                                color: Theme.of(context).primaryColor
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            Icon(Icons.info)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ),
                        ],
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        
                        Expanded(
                          //TODO: löschen? flex: 2,
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow:[
                                  BoxShadow(
                                    color: Theme.of(context).shadowColor,
                                    blurRadius: 6,
                                    offset: Offset(0, 3)
                                  )
                                ],
                              ),
                                            
                              //TODO
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                            onPressed: () => fullscreenTableAllergensAndSymptoms(context),
                                            tooltip: "Detaillierte Ansicht",
                                            icon: Icon(Icons.fullscreen),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: ZusammenhangAllergeneSymptome( 
                                            key: ValueKey(forceUpdate),   // added key to refresh widgets
                                            timeframe: durationTimeframe, 
                                            finalTable: finalTable, 
                                            endDate: endDate, 
                                            startDate: startDate, 
                                            updateAllergenSymptomTable: updateAllergenSymptomTable,
                                            callTimeframeSelector: callTimeframeSelector,
                                            summedView: true,
                                            controllerFructose: controllerFructose,
                                            controllerLactose: controllerLactose,
                                            controllerSorbitol: controllerSorbitol,
                                            glutenWithTraces: glutenWithTraces,
                                            setGlutenWithTraces: setGlutenWithTraces,
                                            selectedSymptoms: selectedSymptoms,
                                            updateAllClusters: updateAllClusters
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ),
                ],
              )

            ))
        ],
      ),
    );
  }

  //Make Table Full Screen
  void fullscreenTableMealsAndSymptoms(BuildContext context){
    showDialog(
      context: context, 
      builder: (context) {

        return StatefulBuilder(
          builder: (context, setStateDialog) {

            return Dialog(
              insetPadding: EdgeInsets.all(30),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: Text("Mahlzeiten und Symptome"),
                  actions: [
                    IconButton(
                      style: Theme.of(context).iconButtonTheme.style,
                      onPressed: () {
                        setState(() {
                          toggleDensity = !toggleDensity;
                          Navigator.of(context).pop();
                          fullscreenTableMealsAndSymptoms(context);
                        });
                      }, 
                      tooltip: toggleDensity ? "Mahlzeiten komprimieren" : "Mahlzeiten komplett anzeigen",
                      icon: toggleDensity ? Icon(Icons.compress) : Icon(Icons.expand)
                    ),
                            
                    IconButton(
                      style: Theme.of(context).iconButtonTheme.style,
                      onPressed: () {
                        Navigator.of(context).pop();
                        //TODO toggleDensity = false;
                      }, 
                      icon: Icon(Icons.close_fullscreen),
                      tooltip: "Tabelle schließen",
                    )
                  ],
                ),
                body: Padding(
                  padding: EdgeInsets.all(15),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return MealAndSymptomDisplay(
                        key: ValueKey(forceUpdate),   // added key to refresh widgets
                        constraints: constraints, 
                        filterTimeframe: durationTimeframe, 
                        showAllColumns: true, 
                        finalTable: finalTable, 
                        endDate: endDate, 
                        startDate: startDate, 
                        toggleDensity: toggleDensity,
                        //TODO updateFinalTable: updateFinalTable,
                        updateNutritionalValues: changeNutritionalValue,
                        filterTable: filterTable,
                        showFructose: showFructoseClusters,
                        showLactose: showLactoseClusters,
                        showSorbitol: showSorbitolClusters,
                        showGluten: showGlutenClusters,
                      );
                    }
                  ),
                ),
              ),
            );
          }
        );
      }
    );
  }

  // fullscreen table for allergen/symptom overview
  void fullscreenTableAllergensAndSymptoms(BuildContext context){
    showDialog(
      context: context, 
      builder: (context) {

        return StatefulBuilder(
          builder: (context, setStateDialog) {

            return Dialog(
              insetPadding: EdgeInsets.all(30),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: Text("Detaillierte Übersicht von Allergene über Schwellenwert pro Symptom"),
                  actions: [
                    IconButton(
                      style: Theme.of(context).iconButtonTheme.style,
                      onPressed: () {
                        Navigator.of(context).pop();
                        //TODO toggleDensity = false;
                      }, 
                      icon: Icon(Icons.close_fullscreen),
                      tooltip: "Tabelle schließen",
                    )
                  ],
                ),
                body: Padding(
                  padding: EdgeInsets.all(15),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return ZusammenhangAllergeneSymptome( 
                        key: ValueKey(forceUpdate),   // added key to refresh widgets
                        timeframe: durationTimeframe, 
                        finalTable: finalTable, 
                        endDate: endDate, 
                        startDate: startDate, 
                        updateAllergenSymptomTable: updateAllergenSymptomTable,
                        callTimeframeSelector: callTimeframeSelector,
                        summedView: false,
                        controllerFructose: controllerFructose,
                        controllerLactose: controllerLactose,
                        controllerSorbitol: controllerSorbitol,
                        glutenWithTraces: glutenWithTraces,
                        setGlutenWithTraces: setGlutenWithTraces,
                        selectedSymptoms: selectedSymptoms,
                        updateAllClusters: updateAllClusters,
                      );
                    }
                  ),
                ),
              ),
            );
          }
        );
      }
    );
  }

  void _createFinalTable(int? filterTimeframe, bool showFructoseClusters){
    // Set bool to determine if filtering should be done (only if timeframe given)
    final timeframeGiven = filterTimeframe != null;

    // make sure joint Table is empty in beginning
    finalTable.clear();

    // populate table with meal data
    for(var meal in mealState.meals){

      // calculate nutritional facts
      double meal_fructose = 0.0;
      double meal_lactose = 0.0;
      double meal_sorbitol = 0.0;
      GlutenAmount? meal_gluten = GlutenAmount.GLUTEN_FREE;

      // create List of mealComponents, to edit in case of changed nutritional values
      List<MealComponentForDietitian> tempListMealComponents = meal.mealComponents;

      // change entry if changes were made
      // go through all changes saved in browser
      for(var entry in loadTableFromBrowser()){  
        // Find matching meal
        if(meal.id == entry.mealID){
          // Find specific ingredient in meal
          for(var component in tempListMealComponents){
            if((component.ingredientId == null || component.ingredientId == -1) && // only change if ingredientId is null / -1 (already updated) TODO: check if -1 is necessary
              component.displayName == entry.displayName &&
              component.amountGram == entry.amountGram &&
              component.amountPortion == entry.amountPortion &&
              component.inputUnit == entry.inputUnit){
                // change values
                component.fructoseAmount = entry.fructoseAmount;
                component.lactoseAmount = entry.lactoseAmount;
                component.sorbitAmount = entry.sorbitAmount;
                component.containsGluten = entry.containsGluten;
                component.ingredientId = entry.ingredientId;
            }  
          }
        }
      }


      for(var m in tempListMealComponents){
          meal_fructose += (m.fructoseAmount == null ? 0.0 : m.fructoseAmount!.toDouble());
          meal_lactose += (m.lactoseAmount == null ? 0.0 : m.lactoseAmount!.toDouble());
          meal_sorbitol += (m.sorbitAmount == null ? 0.0 : m.sorbitAmount!.toDouble());
          meal_gluten = ((meal_gluten == GlutenAmount.CONTAINS_GLUTEN || m.containsGluten == GlutenAmount.CONTAINS_GLUTEN) 
                            ? GlutenAmount.CONTAINS_GLUTEN 
                            : ((meal_gluten == GlutenAmount.CONTAINS_TRACES || m.containsGluten == GlutenAmount.CONTAINS_TRACES)
                                  ? GlutenAmount.CONTAINS_TRACES
                                  : GlutenAmount.GLUTEN_FREE));
      }

      // convert from mg to g and round to one decimal
      meal_fructose = double.parse((meal_fructose / 1000).toStringAsFixed(1));
      meal_lactose = double.parse((meal_lactose / 1000).toStringAsFixed(1));
      meal_sorbitol = double.parse((meal_sorbitol / 1000).toStringAsFixed(1));

      finalTable.add(MealsAndSymptoms(
        isInTimeframe : false,
        isSymptom: false,
        firstEntryOfDay: false,
        dateTime: meal.dateTime.toLocal(), 
        text: "",      // fill it later to dynamically adjust to toggleDensity
        mealComponents: tempListMealComponents,  
        // TODO:
        fructose: meal_fructose,   // TODO: Fructose
        lactose: meal_lactose,   // TODO: Lactose
        sorbitol: meal_sorbitol,   // TODO: Sorbitol
        gluten: meal_gluten,    // TODO
        isMissingNutritionFacts: false,
        mealID: meal.id,
        leadToSymptom: false,
        clusterHighFructose: false,
        clusterHighLactose: false,
        clusterHighSorbitol: false,
        clusterGluten: false,
      ));
    }

    // populate with sympto data
    for(var symptom in symptomReportsState.symptomReports){
      finalTable.add(MealsAndSymptoms(
        isInTimeframe : false,
        isSymptom: true,
        firstEntryOfDay: false,
        dateTime: symptom.dateTime.toLocal(), 
        text: symptom.symptom,
        impairment: symptom.impairment,
        intoleranceCandidate: symptom.intoleranceCandidate,
        allergyCandidate: symptom.allergyCandidate,
        generalWarningCandidate: symptom.generalWarningCandidate,
        mealID: null,
        clusterHighFructose: false,
        clusterHighLactose: false,
        clusterHighSorbitol: false,
        clusterGluten: false,
      ));
    }

    // find out if all nutritional facts are found (if meal is in database)
    for(var entry in finalTable){
      if(!entry.isSymptom){
        for(var e in entry.mealComponents!){
          if(e.ingredientId == null || e.ingredientId == -1){
            entry.isMissingNutritionFacts = true;
          }
        }
      }
    }

    // sort table
    finalTable.sort((a, b) => a.dateTime.compareTo(b.dateTime),);

    // Set the lastSymptomOfDay
    DateTime dayPreviousEntry = DateTime(
      finalTable.first.dateTime.year,
      finalTable.first.dateTime.month,
      finalTable.first.dateTime.day
    );
    for(var val in finalTable){
      if(DateTime(val.dateTime.year, val.dateTime.month, val.dateTime.day).isAfter(dayPreviousEntry)){
        val.firstEntryOfDay = true;
        dayPreviousEntry = DateTime(val.dateTime.year, val.dateTime.month, val.dateTime.day);
      }
    }

    // Set isInTimeframe
    if(timeframeGiven){
      DateTime lastXHours;

      // Iterate through symptomreports
      for(var val in symptomReportsState.symptomReports){
        lastXHours = val.dateTime.toLocal().subtract(Duration(hours: filterTimeframe));

        // determine if this symptom has been selected
        bool symptomIsSelected = false;
        for(var selected in selectedSymptoms){
          if(val.symptom == selected.text){
            symptomIsSelected = true;
          }
        }

          // Iterate through combinedList
          for(var entry in finalTable){
            if((entry.dateTime.isAfter(lastXHours) && entry.dateTime.isBefore(val.dateTime)) || entry.dateTime.isAtSameMomentAs(val.dateTime) || entry.dateTime.isAtSameMomentAs(lastXHours)){
              // If symptoms have been selected, then only highlight those 
              if(selectedSymptoms.isNotEmpty){
                if(symptomIsSelected){
                  entry.isInTimeframe = true;
                }
              }
              // if no symptom is selected, highlight all
              else {
                entry.isInTimeframe = true;
              }
            }
          }
      }
    }

    //update the nutritional facts based on clusters:
    for(var cluster in clustersInTimeframe){
      double fructose = 0.0;
      double lactose = 0.0;
      double sorbitol = 0.0;
      GlutenAmount gluten = GlutenAmount.GLUTEN_FREE;

      for(var mealInCluster in cluster){
          fructose += mealInCluster.fructose ?? 0;
          lactose += mealInCluster.lactose ?? 0;
          sorbitol += mealInCluster.sorbitol ?? 0;
          gluten = (mealInCluster.gluten == GlutenAmount.CONTAINS_GLUTEN || gluten == GlutenAmount.CONTAINS_GLUTEN 
                                ? GlutenAmount.CONTAINS_GLUTEN 
                                : (mealInCluster.gluten == GlutenAmount.CONTAINS_TRACES || gluten == GlutenAmount.CONTAINS_TRACES
                                      ? GlutenAmount.CONTAINS_TRACES
                                      : gluten
                                  )
                    );
        }
      
      //determine if any nutritional facts in cluster are above the threshold    
      if(fructose >= (num.tryParse((controllerFructose.text == "" ? "0" : controllerFructose.text).trim().toString().replaceAll(",", ".").replaceAll(" ", "")) ?? (fructose + 1))){ // If controller == null, then make if clause impossible //TODO: sollte nun nicht mehr eintreten (mit regex, bzw hier == "")
        for(var updateMeal in finalTable){
          for(var mealInCluster in cluster){
            if(updateMeal.mealID == mealInCluster.mealID && updateMeal.dateTime == mealInCluster.dateTime){ // Since symptoms dont have mealID, also match time
              updateMeal.clusterHighFructose = true;
            }
          }
        }
      }

      if(lactose >= (num.tryParse((controllerLactose.text == "" ? "0" : controllerLactose.text).trim().toString().replaceAll(",", ".").replaceAll(" ", "")) ?? (lactose + 1))){ // If controller == null, then make if clause impossible //TODO: sollte nun nicht mehr eintreten (mit regex, bzw hier == "")
        for(var updateMeal in finalTable){
          for(var mealInCluster in cluster){
            if(updateMeal.mealID == mealInCluster.mealID && updateMeal.dateTime == mealInCluster.dateTime){ // Since symptoms dont have mealID, also match time
              updateMeal.clusterHighLactose = true;
            }
          }
        }
      }

      if(sorbitol >= (num.tryParse((controllerSorbitol.text == "" ? "0" : controllerSorbitol.text).trim().toString().replaceAll(",", ".").replaceAll(" ", "")) ?? (sorbitol + 1))){ // If controller == null, then make if clause impossible //TODO: sollte nun nicht mehr eintreten (mit regex, bzw hier == "")
        for(var updateMeal in finalTable){
          for(var mealInCluster in cluster){
            if(updateMeal.mealID == mealInCluster.mealID && updateMeal.dateTime == mealInCluster.dateTime){ // Since symptoms dont have mealID, also match time
              updateMeal.clusterHighSorbitol = true;
            }
          }
        }
      }

      if(gluten == GlutenAmount.CONTAINS_GLUTEN || gluten == GlutenAmount.CONTAINS_TRACES){
        for(var updateMeal in finalTable){
          for(var mealInCluster in cluster){
            if(updateMeal.mealID == mealInCluster.mealID && updateMeal.dateTime == mealInCluster.dateTime){ // Since symptoms dont have mealID, also match time
              updateMeal.clusterGluten = true;
            }
          }
        }
      }
    }
  }
} 


// Create class for List of Meals + Symptoms
class MealsAndSymptoms{
  bool isInTimeframe;             // Needed for Design
  final bool isSymptom;           // Needed for Design
  bool firstEntryOfDay;           // Needed for Design
  final DateTime dateTime;
  final String text;
  final List<MealComponentForDietitian>? mealComponents;
  final int? impairment;
  final bool? intoleranceCandidate;
  final bool? allergyCandidate;
  final bool? generalWarningCandidate;
  final double? fructose;  
  final double? lactose;  
  final double? sorbitol;  
  final GlutenAmount? gluten;  
  bool? isMissingNutritionFacts;
  final int? mealID;
  bool? leadToSymptom;  
  bool clusterHighFructose;
  bool clusterHighLactose;
  bool clusterHighSorbitol;
  bool clusterGluten;

  MealsAndSymptoms({
    required this.isInTimeframe,
    required this.isSymptom,
    required this.firstEntryOfDay,
    required this.dateTime, 
    required this.text,
    this.mealComponents,
    this.impairment,
    this.intoleranceCandidate,
    this.allergyCandidate,
    this.generalWarningCandidate,
    this.fructose,
    this.lactose,
    this.sorbitol,
    this.gluten,
    this.isMissingNutritionFacts,
    required this.mealID,
    this.leadToSymptom,
    required this.clusterHighFructose,
    required this.clusterHighLactose,
    required this.clusterHighSorbitol,
    required this.clusterGluten
    });
}