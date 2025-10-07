import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:dietitian_dashboard/diary/diary_display.dart';

class SymptomSelector extends StatefulWidget{
  final List<MealsAndSymptoms> finalTable;
  final MultiSelectController<MealsAndSymptoms> symptomController;
  final void Function(List<MealsAndSymptoms>) updateSelectedSymptoms;
  final List<DropdownItem<MealsAndSymptoms>> dropdownSymptomOptions;

  const SymptomSelector({
    super.key,
    required this.finalTable,
    required this.symptomController,
    required this.updateSelectedSymptoms,
    required this.dropdownSymptomOptions,
    });

    @override
    State<SymptomSelector> createState() => _SymptomSelectorState();
}

class _SymptomSelectorState extends State<SymptomSelector>{
  late List<MealsAndSymptoms> finalTable;
  late List<DropdownItem<MealsAndSymptoms>> dropdownSymptomOptions = [];
  late MultiSelectController<MealsAndSymptoms> symptomController;
  List<MealsAndSymptoms> selectedSymptoms = [];
  late void Function(List<MealsAndSymptoms>) updateSelectedSymptoms;

  @override
  void initState(){
    super.initState();
    finalTable = widget.finalTable;
    dropdownSymptomOptions = widget.dropdownSymptomOptions;
    symptomController = widget.symptomController;
    updateSelectedSymptoms = widget.updateSelectedSymptoms;
  }
    

  @override
  Widget build(BuildContext context) {

    return MultiDropdown<MealsAndSymptoms>(
      items: dropdownSymptomOptions,
      controller: symptomController,

      onSelectionChange: (selection){
        selectedSymptoms = selection;
        updateSelectedSymptoms(selectedSymptoms);
      },

      chipDecoration: ChipDecoration(
        backgroundColor: Theme.of(context).cardColor,
        labelStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 10
        ),
        wrap: false
      ),

      fieldDecoration: FieldDecoration(
        labelText: null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.grey
          )
        ),
        hintText: "Symptom(e) auswählen...",
        hintStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 15
        ),
      ),

      dropdownItemDecoration: DropdownItemDecoration(
        textColor: Theme.of(context).primaryColor,
        selectedTextColor: Theme.of(context).primaryColorDark
      ),

      
    );
  }
}
