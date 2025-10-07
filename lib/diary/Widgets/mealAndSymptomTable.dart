import 'package:dietitian_dashboard/diary/Widgets/missingNutritionalFacts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;   // needs to hide textdirection, otherwise overwrites TextDirection from material package
import 'package:dietitian_dashboard/diary/diary_display.dart';
import 'package:viatolea_api/api.dart';
import 'package:dietitian_dashboard/diary/Widgets/saveDataInBrowser.dart';
import 'package:data_table_2/data_table_2.dart';

class MealAndSymptomDisplay extends StatefulWidget{

  final BoxConstraints constraints;
  final int? filterTimeframe;
  final bool showAllColumns;
  final List<MealsAndSymptoms> finalTable;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool toggleDensity;
  final void Function(List<SaveMealComponentsInBrowser>, BuildContext, bool) updateNutritionalValues;
  final void Function(String) filterTable;
  final bool showFructose;
  final bool showLactose;
  final bool showSorbitol;
  final bool showGluten;

  const MealAndSymptomDisplay({
    super.key,
    required this.constraints,
    required this.filterTimeframe,
    required this.showAllColumns,
    required this.finalTable,
    required this.endDate,
    required this.startDate,
    required this.toggleDensity,
    required this.updateNutritionalValues,
    required this.filterTable,
    required this.showFructose,
    required this.showLactose,
    required this.showSorbitol,
    required this.showGluten,
    });

    @override
    State<MealAndSymptomDisplay> createState() => _MealAndSymptomDisplayState();
}

class _MealAndSymptomDisplayState extends State<MealAndSymptomDisplay>{
  late BoxConstraints constraints;
  late int? filterTimeframe;
  late bool showAllColumns;
  late List<MealsAndSymptoms> finalTable;
  late DateTime? startDate;
  late DateTime? endDate;
  late bool toggleDensity;
  late Function(List<SaveMealComponentsInBrowser>, BuildContext, bool) updateNutritionalValues;
  late void Function(String) filterTable;
  late bool showFructose;
  late bool showLactose;
  late bool showSorbitol;
  late bool showGluten;

  // to select a row in the table
  int? selectedRow;

  @override
  void initState(){
    super.initState();
    constraints = widget.constraints;
    filterTimeframe = widget.filterTimeframe;
    showAllColumns = widget.showAllColumns;
    finalTable = widget.finalTable;
    startDate = widget.startDate;
    endDate = widget.endDate;
    toggleDensity = widget.toggleDensity;
    updateNutritionalValues = widget.updateNutritionalValues;
    filterTable = widget.filterTable;
    showFructose = widget.showFructose;
    showLactose = widget.showLactose;
    showSorbitol = widget.showSorbitol;
    showGluten = widget.showGluten;
  }
  

  @override
  Widget build(BuildContext context) {
  // Build Table (either full screen or not)

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

  // Fill List with initial values (width of column titles)
  final List<double> widthColumsTable = [
    measureWidthOfValue("Datum", context),
    measureWidthOfValue("Mahlzeit / Symptom", context),
    measureWidthOfValue("Impairment", context),
    measureWidthOfValue("Fruktose", context),
    measureWidthOfValue("Laktose", context),
    measureWidthOfValue("Sorbit", context),
    measureWidthOfValue("Gluten", context),
    measureWidthOfValue("___", context)           // Column for "!" if nutritional facts are wrong
  ];

  //loop through finalTable to fill width list
  for(var val in finalTable){
    
    // conditionally adjust list
    if(widthColumsTable[0] < measureWidthOfValue(DateFormat("dd.MM.yy HH:mm").format(val.dateTime), context)){
      widthColumsTable[0] = measureWidthOfValue(DateFormat("dd.MM.yy HH:mm").format(val.dateTime), context);
    }
    // set widthColumsTable[1] later
    
    if(widthColumsTable[2] < measureWidthOfValue(val.impairment.toString(), context) && val.impairment != null){
      widthColumsTable[2] = measureWidthOfValue(val.impairment.toString(), context);
    }
    if(widthColumsTable[3] < measureWidthOfValue(val.fructose.toString(), context) && val.fructose != null){
      widthColumsTable[3] = measureWidthOfValue(val.fructose.toString(), context);
    }
    if(widthColumsTable[4] < measureWidthOfValue(val.lactose.toString(), context) && val.lactose != null){
      widthColumsTable[4] = measureWidthOfValue(val.lactose.toString(), context);
    }
    if(widthColumsTable[5] < measureWidthOfValue(val.sorbitol.toString(), context) && val.sorbitol != null){
      widthColumsTable[5] = measureWidthOfValue(val.sorbitol.toString(), context);
    }
    if(widthColumsTable[6] < measureWidthOfValue(val.gluten.toString(), context) && val.gluten != null){
      widthColumsTable[6] = measureWidthOfValue(val.gluten.toString(), context);
    }
    // TODO: add gluten?
  }

  // Add a little padding
  for(var i=0; i<widthColumsTable.length; i++){
    widthColumsTable[i] += 30;
  }
  

  // set remainingWidth
  double remainingWidth = constraints.maxWidth;
  widthColumsTable[1] = 55.0;   // incl. padding (15 column, 2*20 each side)

  if(showAllColumns){
    for(var i=0; i<widthColumsTable.length; i++){
      remainingWidth -= widthColumsTable[i]; 
    }

    // adjust for later column spacing
    remainingWidth -=  60; //(6 gaps, each 10 spacing)
  }
  else{
    remainingWidth -= widthColumsTable[0]; 

    // adjust for later column spacing
    remainingWidth -= 50; //(1 gap, 10 spacing) + padding for each side (2 * 20)
  }

  //create rows
  final List<DataRow> rowsTable = [];


  // Create Cells of row
  int prevIndex = 0;
  for(var entry in finalTable.asMap().entries) {      // Use asMap() to count index (required for selecting rows)
    // check if nutrition facts are missing, if no, then row should not be selectable (have no index)
    final index = entry.value.isSymptom ? null : (entry.value.isMissingNutritionFacts! ? entry.key : null); 
    final e = entry.value;
    
    final daySeperatorIndex = entry.key;

    // Only contain values in timeframe
    if(
      ((DateTime(e.dateTime.year, e.dateTime.month, e.dateTime.day)
      .isAfter(DateTime(startDate!.year, startDate!.month, startDate!.day)
      ) 
      && 
      DateTime(e.dateTime.year, e.dateTime.month, e.dateTime.day)
      .isBefore(DateTime(endDate!.year, endDate!.month, endDate!.day))
      )
      ||
      DateTime(e.dateTime.year, e.dateTime.month, e.dateTime.day)
      .isAtSameMomentAs(DateTime(startDate!.year, startDate!.month, startDate!.day))
      ||
      DateTime(e.dateTime.year, e.dateTime.month, e.dateTime.day)
      .isAtSameMomentAs(DateTime(endDate!.year, endDate!.month, endDate!.day)))

      // if a filter depending on allergen is given, then only use those that are marked, otherwise true (all)
       && (
        e.isSymptom ||
        // if all off, then all data
        (showFructose == false && showGluten == false && showSorbitol == false && showLactose == false) 
            ? true 
            : ((showFructose ? e.clusterHighFructose : false) || (showLactose ? e.clusterHighLactose : false) || (showSorbitol ? e.clusterHighSorbitol : false) || (showGluten ? e.clusterGluten : false))
              
            

       )// TODO: now the 2firstmealofDay bool is wrong
    ){      
      final cells = <DataCell>[
        DataCell(
          /* TESTING
          SizedBox(
            width: widthColumsTable[0],
            child: Text(
              DateFormat("dd.MM.yy HH:mm").format(e.dateTime),
              overflow: TextOverflow.ellipsis,  // prevents wrapping of time
              ),
          )
          */
          // TESTER (below this)
         Text(
              DateFormat("dd.MM.yy HH:mm").format(e.dateTime),
              overflow: TextOverflow.ellipsis,  // prevents wrapping of time
              ),
         
          // TESTER (above this)
        ),

        /*TESTING
        DataCell(
          SizedBox(
            width: remainingWidth,
            child: Text.rich(
              TextSpan(
                children: e.isSymptom 
                  ? [TextSpan(
                      text: e.text,
                      style: TextStyle(
                          color: Colors.red,
                      )
                    )]
                  : e.mealComponents!.map((i) {
                    
                    // generate the text (with amount if not denser view)
                    var text = toggleDensity
                    ? "${i.amountGram}g ${i.displayName}"
                    : i.displayName;

                    // add a comma and space, except for last element in list
                    if(i != e.mealComponents!.last){ 
                      text += ", ";
                    }

                    return TextSpan(
                      text: text,
                      // If ingredientId is null (no match found in database), then highlight
                      style: TextStyle(
                        fontWeight: i.ingredientId == null ? FontWeight.bold : FontWeight.normal,
                        color: i.ingredientId == null ? Colors.red : Colors.black,
                      )
                    );
                  },
                ).toList()
              ),
              softWrap: true,
              maxLines: null,
              overflow: toggleDensity ? null : TextOverflow.ellipsis, //TODO: löschen
          
            )
          )
        )*/
        // TESTER (below this)
        DataCell(
          Text.rich(
            TextSpan(
              children: e.isSymptom 
                ? [TextSpan(
                    text: e.text.toString(),
                    style: TextStyle(
                        color: Colors.red,
                    )
                  ),
                  TextSpan(
                    text: ((e.allergyCandidate ?? false) ? "   (Allergiesymptom!)" : ""),
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    )
                  )
                  ]
                : e.mealComponents!.map((i) {
                  
                  // generate the text (with amount if not denser view)
                  var text = toggleDensity
                  ? "${i.amountGram}g ${i.displayName}"
                  : i.displayName;
          
                  // add a comma and space, except for last element in list
                  if(i != e.mealComponents!.last){ 
                    text += ", ";
                  }
          
                  return TextSpan(
                    text: text,
                    // If ingredientId is null (no match found in database), then highlight
                    style: TextStyle(
                      fontWeight: i.ingredientId == null ? FontWeight.bold : FontWeight.normal,
                      color: i.ingredientId == null ? Colors.red : Colors.black,
                    )
                  );
                },
              ).toList()
            ),
            softWrap: true,
            maxLines: null,
            overflow: toggleDensity ? null : TextOverflow.ellipsis, //TODO: löschen
                    
          )
        )
        // TESTER (above this)
      ];
      
      /* TESTING
      if(showAllColumns){
        cells.addAll([
          DataCell(SizedBox(width: widthColumsTable[2],child: Text(e.impairment?.toString() ?? ''))),
          DataCell(SizedBox(width: widthColumsTable[3],child: Text(e.fructose == null ? "" : "${e.fructose!.toString()}g"))),   // TODO: Fructose
          DataCell(SizedBox(width: widthColumsTable[4],child: Text(e.lactose == null ? "" : "${e.lactose!.toString()}g"))),   // TODO: Lactose
          DataCell(SizedBox(width: widthColumsTable[5],child: Text(e.sorbitol == null ? "" : "${e.sorbitol!.toString()}g"))),   // TODO: Sorbitol
          DataCell(SizedBox(width: widthColumsTable[6],child: Text(
            (e.gluten == null 
              ? ""
              : (e.gluten! == GlutenAmount.GLUTEN_FREE
                    ? "Glutenfrei"
                    : (e.gluten! == GlutenAmount.CONTAINS_GLUTEN
                          ? "Enthält Gluten"
                          : "Enthält Spuren"))
            )
          ))),
          DataCell(
            SizedBox(
              width: widthColumsTable[7],
              child: (e.isMissingNutritionFacts == null 
                          ? Text('') 
                          : (e.isMissingNutritionFacts! 
                                ? Tooltip(
                                  message: "(Teilweise) Kein Treffer der Lebensmittel",
                                  child: Icon(Icons.error_outline_rounded))
                                : Text('')
                            )
                      )
            )
          ),   
          
        ]);
      }*/
      // TESTER (below this)
      if(showAllColumns){
        cells.addAll([
          DataCell(Align(alignment: Alignment.center, child: Text(e.impairment?.toString() ?? ''))),
          DataCell(Align(alignment: Alignment.center, child: Text(e.fructose == null ? "" : "${e.fructose!.toString()}g"))),   // TODO: Fructose
          DataCell(Align(alignment: Alignment.center, child: Text(e.lactose == null ? "" : "${e.lactose!.toString()}g"))),   // TODO: Lactose
          DataCell(Align(alignment: Alignment.center, child: Text(e.sorbitol == null ? "" : "${e.sorbitol!.toString()}g"))),   // TODO: Sorbitol
          DataCell(Align(alignment: Alignment.center, child: Text(
            (e.gluten == null 
              ? ""
              : (e.gluten! == GlutenAmount.GLUTEN_FREE
                    ? "Glutenfrei"
                    : (e.gluten! == GlutenAmount.CONTAINS_GLUTEN
                          ? "Enthält Gluten"
                          : "Enthält Spuren"))
            )
          ))),
          DataCell(
            (e.isMissingNutritionFacts == null 
                        ? Text('') 
                        : (e.isMissingNutritionFacts! 
                              ? Tooltip(
                                message: "(Teilweise) Kein Treffer der Lebensmittel",
                                child: Icon(Icons.error_outline_rounded))
                              : Text('')
                          )
                    )
          ),   
          
        ]);
      }
      // TESTER (above this)
      
      // Add a blank row as divider (only if not first row)
      /* TESTING
      if(e.firstEntryOfDay && rowsTable.isNotEmpty){
        rowsTable.add(
          DataRow(
            cells: showAllColumns ?
            [
              DataCell(SizedBox(width: widthColumsTable[0],child: Container(height: 1,color: Colors.grey,))),
              DataCell(SizedBox(width: remainingWidth, child: Container(height: 1,color: Colors.grey,))),
              DataCell(SizedBox(width: widthColumsTable[2],child: Container(height: 1,color: Colors.grey,))),
              DataCell(SizedBox(width: widthColumsTable[3],child: Container(height: 1,color: Colors.grey,))),
              DataCell(SizedBox(width: widthColumsTable[4],child: Container(height: 1,color: Colors.grey,))),
              DataCell(SizedBox(width: widthColumsTable[5],child: Container(height: 1,color: Colors.grey,))),
              DataCell(SizedBox(width: widthColumsTable[6],child: Container(height: 1,color: Colors.grey,))),
              DataCell(SizedBox(width: widthColumsTable[7],child: Container(height: 1,color: Colors.transparent,))),
            ] 
            : [
              DataCell(SizedBox(width: widthColumsTable[0], child: Container(height: 1,color: Colors.grey,))),
              DataCell(SizedBox(width: remainingWidth, child: Container(height: 1,color: Colors.grey,))),
            ]
          )
        );
      }*/
      // TESTER (below this)
      //if(e.firstEntryOfDay && rowsTable.isNotEmpty){ TODO: remove this part + firstEntryOfDay
      if(rowsTable.isNotEmpty && (DateTime(finalTable[prevIndex].dateTime.year, finalTable[prevIndex].dateTime.month, finalTable[prevIndex].dateTime.day) != DateTime(finalTable[daySeperatorIndex].dateTime.year, finalTable[daySeperatorIndex].dateTime.month, finalTable[daySeperatorIndex].dateTime.day))){
        rowsTable.add(
          DataRow(
            cells: showAllColumns ?
            [
              DataCell(Container(height: 1,color: Colors.grey,)),
              DataCell(Container(height: 1,color: Colors.grey,)),
              DataCell(Container(height: 1,color: Colors.grey,)),
              DataCell(Container(height: 1,color: Colors.grey,)),
              DataCell(Container(height: 1,color: Colors.grey,)),
              DataCell(Container(height: 1,color: Colors.grey,)),
              DataCell(Container(height: 1,color: Colors.grey,)),
              DataCell(Container(height: 1,color: Colors.transparent,)),
            ] 
            : [
              DataCell(Container(height: 1,color: Colors.grey,)),
              DataCell(Container(height: 1,color: Colors.grey,)),
            ]
          )
        );
      }

      //update prev index
      prevIndex = daySeperatorIndex;
      // TESTER (above this)
      
      // Add row (with color coding)
      rowsTable.add(DataRow2(
        // Row only clickable if index given (if nutritional facts are missing)
        onSelectChanged: index != null ? (_){
          setState(() {
            selectedRow = index;
          }); 

          // call function to update nutrients
          showPopUpAddNutrientFacts(context, entry.value.mealID!, finalTable, updateNutritionalValues, showAllColumns);
        } : null,
        selected: selectedRow == index,
        // TESTING (ACHTUNG!!!: DataRow -> DataRow2)
        color: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states){
            return e.isInTimeframe ? Colors.amber : Colors.transparent;   // TODO: different colors
          }
        ),//
        // TESTER (below this)
       
/*decoration:  e.isInTimeframe ? BoxDecoration(
  gradient: LinearGradient(
    colors: [Colors.red, Colors.red,Colors.amber, Colors.amber, Colors.red, Colors.red,Colors.amber, Colors.amber, Colors.red, Colors.red,Colors.amber, Colors.amber, Colors.red, Colors.red,Colors.amber, Colors.amber],
    begin: Alignment.topLeft,
    end: Alignment(-0.9, 0),
    stops: [0.0, 0.125, 0.125, 0.25, 0.25, 0.375, 0.375, 0.5, 0.5, 0.625, 0.625, 0.75, 0.75, 0.875, 0.875, 1],
    tileMode: TileMode.repeated
  ) 
) : BoxDecoration(color: Colors.transparent) ,*/
        //TESTER (above this)
        cells: cells)
      ); 
    }     
  }
        
  // return if fullscreen all data (7 columns) or small view (2 columns) // Todo: 8 Spalten?
  /*TESTING
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Theme(
      data: Theme.of(context).copyWith(
        dividerTheme: DividerThemeData(
          color: Colors.transparent
        )
      ),
      child: DataTable(
        showCheckboxColumn: false,
        dataRowMinHeight: 1,
        dataRowMaxHeight: toggleDensity ? null : 20,
        dataRowColor: Theme.of(context).dataTableTheme.dataRowColor,
        headingRowColor: Theme.of(context).dataTableTheme.headingRowColor,
        dataTextStyle: Theme.of(context).dataTableTheme.dataTextStyle,
        headingTextStyle: Theme.of(context).dataTableTheme.headingTextStyle,
        columnSpacing: 10,
        columns: showAllColumns 
          ?  [
            DataColumn(label: SizedBox(width: widthColumsTable[0], child: Text("Datum"))),
            DataColumn(label: SizedBox(width: remainingWidth, child: Text("Mahlzeit / Symptom"))),
            DataColumn(label: SizedBox(width: widthColumsTable[2], child: Text("Impairment"))),
            DataColumn(label: SizedBox(width: widthColumsTable[3], child: Text("Fructose"))),
            DataColumn(label: SizedBox(width: widthColumsTable[4], child: Text("Lactose"))),
            DataColumn(label: SizedBox(width: widthColumsTable[5], child: Text("Sorbitol"))),
            DataColumn(label: SizedBox(width: widthColumsTable[6], child: Text("Gluten"))),
            DataColumn(label: SizedBox(width: widthColumsTable[7], child: Text(""))),
          ]
          :  [
            DataColumn(label: SizedBox(width: widthColumsTable[0], child: Text("Datum"))),
            DataColumn(label: SizedBox(width: remainingWidth, child: Text("Mahlzeit / Symptom"))),
          ], 
        rows: rowsTable,
      )
    ),
  );*/
// TESTER (below this)
  // return if fullscreen all data (7 columns) or small view (2 columns) // Todo: 8 Spalten?
  return DataTable2(
        showCheckboxColumn: false,
        //CHANGE?: dataRowMinHeight: 1,
        //CHANGE?: dataRowMaxHeight: toggleDensity ? null : 20,
        // NEW
        fixedTopRows: 1,
        showHeadingCheckBox: false,
        showBottomBorder: false,
        dividerThickness: 0,
        dataRowHeight: toggleDensity ? null : 20,
        headingRowDecoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey)
          ),
        ),
        // NEW
        dataRowColor: Theme.of(context).dataTableTheme.dataRowColor,
        headingRowColor: Theme.of(context).dataTableTheme.headingRowColor,
        dataTextStyle: Theme.of(context).dataTableTheme.dataTextStyle,
        headingTextStyle: Theme.of(context).dataTableTheme.headingTextStyle,
        columnSpacing: 10,
        columns: showAllColumns 
          ?  [
            // Fruktose, Laktose, Sorbitol, Gluten: Spalten bekommen mehr breite wegen Textbutton
            DataColumn2(fixedWidth: widthColumsTable[0] ,label: Text("Datum")),
            DataColumn2(label: Text("Mahlzeit / Symptom")),
            DataColumn2(fixedWidth: widthColumsTable[2] ,label: Text("Impairment"), headingRowAlignment: MainAxisAlignment.center),

            DataColumn2(fixedWidth: widthColumsTable[3]+20 ,label: Tooltip(
              message: "Filtern nach erhöhtem Fruktosegehalt\ninnerhalb $filterTimeframe Stunden",
              textAlign: TextAlign.center,
              child: TextButton(
                onPressed: () => filterTable("Fructose"),
                style: TextButton.styleFrom(
                  backgroundColor: showFructose ? const Color.fromARGB(255, 18, 67, 20) : Colors.transparent,
                  foregroundColor: showFructose ? Colors.white : null
                ),
                 child: Text("Fruktose", style: Theme.of(context).dataTableTheme.headingTextStyle
                ,),
              ),
            ), 
            headingRowAlignment: MainAxisAlignment.center),
            //DataColumn2(fixedWidth: widthColumsTable[3] ,label: Text("Fruktose"), headingRowAlignment: MainAxisAlignment.center),

            DataColumn2(fixedWidth: widthColumsTable[4]+20 ,label: Tooltip(
              message: "Filtern nach erhöhtem Laktosegehalt\ninnerhalb $filterTimeframe Stunden",
              textAlign: TextAlign.center,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: showLactose ? const Color.fromARGB(255, 18, 67, 20) : Colors.transparent,
                  foregroundColor: showLactose ? Colors.white : null
                ),
                onPressed: () => filterTable("Lactose"),
                child: Text("Laktose", style: Theme.of(context).dataTableTheme.headingTextStyle
                ,),
                ),
            ), headingRowAlignment: MainAxisAlignment.center),

            DataColumn2(fixedWidth: widthColumsTable[5]+20 ,label: Tooltip(
              message: "Filtern nach erhöhtem Sorbitgehalt\ninnerhalb $filterTimeframe Stunden",
              textAlign: TextAlign.center,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: showSorbitol ? const Color.fromARGB(255, 18, 67, 20) : Colors.transparent,
                  foregroundColor: showSorbitol ? Colors.white : null
                ),
                onPressed: () => filterTable("Sorbitol"),
                child: Text("Sorbit", style: Theme.of(context).dataTableTheme.headingTextStyle
                ,),
                ),
            ), headingRowAlignment: MainAxisAlignment.center),

            DataColumn2(fixedWidth: widthColumsTable[6]+20 ,label: Tooltip(
              message: "Filtern nach enthaltenem Gluten\ninnerhalb $filterTimeframe Stunden",
              textAlign: TextAlign.center,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: showGluten ? const Color.fromARGB(255, 18, 67, 20) : Colors.transparent,
                  foregroundColor: showGluten ? Colors.white : null
                ),
                onPressed: () => filterTable("Gluten"),
                child: Text("Gluten", style: Theme.of(context).dataTableTheme.headingTextStyle
                ,),
                ),
            ), headingRowAlignment: MainAxisAlignment.center),
            
            DataColumn2(fixedWidth: widthColumsTable[7] ,label: Text("")),
          ]
          :  [
            DataColumn2(fixedWidth: widthColumsTable[0] ,label: Text("Datum")),
            DataColumn2(label:Text("Mahlzeit / Symptom")),
          ], 
        rows: rowsTable,
  );
  // TESTER (above this)
  }
}