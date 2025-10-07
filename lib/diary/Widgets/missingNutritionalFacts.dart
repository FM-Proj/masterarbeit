import 'package:dietitian_dashboard/diary/diary_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:viatolea_api/api.dart';
import 'package:dietitian_dashboard/diary/Widgets/saveDataInBrowser.dart';

// Just calls the pop up window
Future<void> showPopUpAddNutrientFacts(BuildContext context, int mealID, List<MealsAndSymptoms> finalTable, Function(List<SaveMealComponentsInBrowser>, BuildContext, bool) updateNutritionalValues, bool showAllColumns){
  return showDialog(
    context: context, 
    builder: (_) => UpdateMissingNutrients(mealID: mealID, finalTable: finalTable, updateNutritionalValues: updateNutritionalValues, showAllColumns: showAllColumns)
  );
}

class UpdateMissingNutrients extends StatefulWidget{
  final List<MealsAndSymptoms> finalTable;
  final int mealID;
  final void Function(List<SaveMealComponentsInBrowser>, BuildContext, bool) updateNutritionalValues;
  final bool showAllColumns;

  const UpdateMissingNutrients({
    super.key,
    required this.finalTable,
    required this.mealID,
    required this.updateNutritionalValues,
    required this.showAllColumns,
    });

    @override
    State<UpdateMissingNutrients> createState() => _UpdateMissingNutrientsState();
}

class _UpdateMissingNutrientsState extends State<UpdateMissingNutrients>{
  late List<MealsAndSymptoms> finalTable;
  late int mealID;
  late Function(List<SaveMealComponentsInBrowser>, BuildContext, bool) updateNutritionalValues;
  late bool showAllColumns;

  // String: Name of Mealcomponent, MealsAndSymptoms: meal of component, bool: if already changed
  List<(MealComponentForDietitian, bool)> editTheseMealComponents = [];

  // List of all changed Values
  List<SaveMealComponentsInBrowser> updatedValues = loadTableFromBrowser();

  // For dropdown menu of gluten options
  GlutenAmount? selectedGlutenOption;

  @override
  void initState(){
    super.initState();
    finalTable = widget.finalTable;
    mealID = widget.mealID;
    updateNutritionalValues = widget.updateNutritionalValues;
    showAllColumns = widget.showAllColumns;
    
    for(var entry in finalTable){
      if(entry.mealID == mealID){
        if(entry.isMissingNutritionFacts!){
          // fill values and labels List
          for(var ingredient in entry.mealComponents!){
            if(ingredient.ingredientId == null || ingredient.ingredientId == -1){  // only show ingredients with missing nutritional facts

              // Load bool if already changed
              bool existsInUpdatedValues = false;

              // Go through all updated Values and see if this entry had been previously edited
              for(var y in updatedValues){              
               if(y.mealID == mealID
                    && y.ingredientId == ingredient.ingredientId
                    && y.displayName == ingredient.displayName
                    && y.amountGram == ingredient.amountGram
                    && y.amountPortion == ingredient.amountPortion
                    && y.inputUnit == ingredient.inputUnit
                    && y.fructoseAmount == (ingredient.fructoseAmount ?? 0.0).toDouble()
                    && y.lactoseAmount == (ingredient.lactoseAmount ?? 0.0).toDouble()
                    && y.sorbitAmount == (ingredient.sorbitAmount ?? 0.0).toDouble()
                    && y.containsGluten == (ingredient.containsGluten ?? GlutenAmount.GLUTEN_FREE)){

                      // Set bool to true if this component had been updated previously 
                      existsInUpdatedValues = true;
                }
              }
              editTheseMealComponents.add((ingredient, existsInUpdatedValues));
            }
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
  
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

  List<double> widths = [
    measureWidthOfValue("Zutat ohne Werte", context),
    measureWidthOfValue("Allergene eintragen", context)
  ];
 
  for(var i = 0; i<editTheseMealComponents.length; i++){
    if(measureWidthOfValue("${editTheseMealComponents[i].$1.amountGram}g ${editTheseMealComponents[i].$1.displayName}", context) > widths[0]){
      widths[0] = measureWidthOfValue("${editTheseMealComponents[i].$1.amountGram}g ${editTheseMealComponents[i].$1.displayName}", context);
    }
  }

  // Add padding + gap inbetween columns
  for(var i=0; i<widths.length; i++){
    widths[i] += 75;
  }
    
    return AlertDialog(
      contentPadding: EdgeInsets.all(15), //TODO
      content: SizedBox(
        //width: double.maxFinite,
        width: 500,// TODO: nun: alles auf 400? widths[0] + widths[1],           //TODO: add width of add button
        height: 400,                             //TODO: final heigth?
        child: SingleChildScrollView(
          child: Column(
            children: [
              DataTable(
                showCheckboxColumn: false,
                columns: [
                  DataColumn(label: Text("Zutat ohne Werte")),
                  DataColumn(label: Text("Allergene eintragen")),
                ],
                rows: List.generate(
                  editTheseMealComponents.length,
                  (i) {
                    final colA = "${editTheseMealComponents[i].$1.amountGram}g ${editTheseMealComponents[i].$1.displayName}";
                    final colB = editTheseMealComponents[i].$1;

                    return DataRow.byIndex(
                      index: i,
                      cells: [
                        DataCell(Text(colA)),
                        DataCell(
                          Row(
                            children: [
                              Tooltip(
                                message: editTheseMealComponents[i].$2 ? "Infos bearbeiten" : "Infos eingeben",
                                child: IconButton(
                                  onPressed: () async {
                                    await showExtraDialog(context, colB, i, editTheseMealComponents[i].$2);
                                    setState(() {});
                                  }, 
                                  icon: editTheseMealComponents[i].$2 ? Icon(Icons.edit) : Icon(Icons.add)  // If already updated, then show edit Icon, else show add icon
                                ),
                              ),
                            ],
                          )
                        ),
                      ],
                    );
                  })
              ),
            ]
          ),
        ),
      ),

      // Close Button in top right corner
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(""),
          Text("Fehlende Werte"),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              updateNutritionalValues(updatedValues, context, showAllColumns); //TODO: check 
            }, 
            icon: Icon(Icons.close)
          )
        ],
      ),
      
    ); 
  }


  Future<MealsAndSymptoms?>  showExtraDialog(BuildContext context, MealComponentForDietitian item, int index, bool hasBeenEdited) async {
    final controllerFructose = TextEditingController(text: hasBeenEdited ? ((item.fructoseAmount ?? 0.0) / 1000).toString() : "");
    final controllerLactose = TextEditingController(text: hasBeenEdited ? ((item.lactoseAmount ?? 0.0) / 1000).toString() : "");
    final controllerSorbitol = TextEditingController(text: hasBeenEdited ? ((item.sorbitAmount ?? 0.0) / 1000).toString() : "");
    GlutenAmount? tempSelected =  editTheseMealComponents[index].$1.containsGluten;

    final window = await showDialog<MealsAndSymptoms>(
      context: context,
      builder: (innerPop) => StatefulBuilder(   // Add this to correctly display dropdownbutton
        builder: (innerPop, setStateDialog) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(""),
                Text("Allergene-Daten hinzufügen"),
                IconButton(
                  onPressed: () => Navigator.pop(innerPop), 
                  icon: Icon(Icons.close))
              ],
            ),
            content: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400, maxHeight: 400),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: controllerFructose, 
                      inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*[.,]?\d*$'),  // Regex to allow numbers, with a dot or comma inbetween
                          )
                        ],
                      decoration: const InputDecoration(labelText: "Fruktose (in Gramm) (optional)"),),
                    TextField(
                      controller: controllerLactose, 
                      inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*[.,]?\d*$'),  // Regex to allow numbers, with a dot or comma inbetween
                          )
                        ],
                      decoration: const InputDecoration(labelText: "Laktose (in Gramm) (optional)"),),
                    TextField(
                      controller: controllerSorbitol, 
                      inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*[.,]?\d*$'),  // Regex to allow numbers, with a dot or comma inbetween
                          )
                        ],
                      decoration: const InputDecoration(labelText: "Sorbit (in Milligramm) (optional)"),),
                    
                    DropdownButton<GlutenAmount>(
                      hint: (switch(tempSelected) {
                        GlutenAmount.CONTAINS_GLUTEN => Text("Enthält Gluten"),
                        GlutenAmount.CONTAINS_TRACES => Text("Enthält Spuren von Gluten"),
                        GlutenAmount.GLUTEN_FREE => Text("Glutenfrei"),
                        _ => Text("Gluten?")  // Cannot occur
                      }
                        ),
                      value: tempSelected,
                      onChanged: (GlutenAmount? input) {
                        setStateDialog(() {
                          tempSelected = input;
                        });
                      },
                      items: const [
                        DropdownMenuItem(value: GlutenAmount.CONTAINS_GLUTEN, child: Text("Enthält Gluten")),
                        DropdownMenuItem(value: GlutenAmount.CONTAINS_TRACES, child: Text("Enthält Spuren von Gluten")),
                        DropdownMenuItem(value: GlutenAmount.GLUTEN_FREE, child: Text("Glutenfrei"))
                      ], 
                      isExpanded: true,
                    
                    )
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  // close popup
                  Navigator.pop(innerPop);
                }, 
                child: Text("Cancel")
              ),
              TextButton(
                onPressed: () {
                  // change value 
                  selectedGlutenOption = tempSelected;

                  // if MealComponent is being updated, remove previous entry
                  if(editTheseMealComponents[index].$2){
                    updatedValues.removeWhere((a) {
                      bool isUpdate = false;
      
                      if(
                        a.mealID == mealID &&
                        a.ingredientId == -1 &&  
                        a.displayName == editTheseMealComponents[index].$1.displayName && 
                        a.amountGram == editTheseMealComponents[index].$1.amountGram && 
                        a.amountPortion == editTheseMealComponents[index].$1.amountPortion && 
                        a.inputUnit == editTheseMealComponents[index].$1.inputUnit){
                        
                          isUpdate = true;
                      }
      
                      return isUpdate;
                    });
                  }
      
                  // Also add to updatedValues to save in browser
                  updatedValues.add(SaveMealComponentsInBrowser(
                    mealID: mealID, 
                    ingredientId: -1,   
                    displayName: item.displayName, 
                    amountGram: item.amountGram,
                    amountPortion: item.amountPortion, 
                    inputUnit: item.inputUnit,
                    fructoseAmount: (num.tryParse(controllerFructose.text.trim().toString().replaceAll(",", ".").replaceAll(" ", "")) ?? 0.0) * 1000,   // convert to mg, converted back later (in data saved as mg)
                    sorbitAmount: (num.tryParse(controllerSorbitol.text.trim().toString().replaceAll(",", ".").replaceAll(" ", "")) ?? 0.0) * 1000,
                    lactoseAmount: (num.tryParse(controllerLactose.text.trim().toString().replaceAll(",", ".").replaceAll(" ", "")) ?? 0.0) * 1000,
                    containsGluten: selectedGlutenOption ?? GlutenAmount.GLUTEN_FREE
                  ));
                
                  // save update
                  updateNutritionalValues(updatedValues, context, showAllColumns);
        
                  // update the bool
                  editTheseMealComponents[index] = (editTheseMealComponents[index].$1, true);

                  // close pop up
                  Navigator.pop(innerPop);
                }, 
                child: Text("OK")
              )
        
            ],
          
          );
        },
      ));

    return window;
  }
}