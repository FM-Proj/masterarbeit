import 'package:flutter/material.dart';
import 'package:dietitian_dashboard/diary/diary_display.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class TimeframeSelector extends StatefulWidget{
  final List<MealsAndSymptoms> finalTable;
  final int? durationTimeframe;
  final void Function(int?) updateTimeframe;

  const TimeframeSelector({
    super.key,
    required this.finalTable,
    required this.durationTimeframe,
    required this.updateTimeframe,
    });

    @override
    State<TimeframeSelector> createState() => _TimeframeSelectorState();
}

class _TimeframeSelectorState extends State<TimeframeSelector>{
  late List<MealsAndSymptoms> finalTable;
  late int? durationTimeframe;
  late void Function(int?) updateTimeframe;

  @override
  void initState(){
    super.initState();
    finalTable = widget.finalTable;
    durationTimeframe = widget.durationTimeframe;
    updateTimeframe = widget.updateTimeframe;
  }

  @override
  Widget build(BuildContext context) {

    // Use DropdownButtonHideUnderline to remove underline of DropdownButton
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(15)
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<int?>(
          isExpanded: true,
          isDense: Theme.of(context).dropdownMenuTheme.inputDecorationTheme?.isDense ?? false,
          style: Theme.of(context).dropdownMenuTheme.textStyle,
          hint: Text(
            "Berücksichtigte Dauer (vor Symptomen)",
            style: Theme.of(context).dropdownMenuTheme.inputDecorationTheme?.hintStyle ?? TextStyle(color: Theme.of(context).hintColor)),
          value: durationTimeframe,
          onChanged: (int? enteredValue){
            setState(() {
              durationTimeframe = enteredValue;
            });

            //set parent state too
            updateTimeframe(durationTimeframe);
          },
          items: [
            const DropdownMenuItem<int?>(
              value: null,
              child: Text("Kein Zeitfenster"),
            ),
            ...[2, 4, 6, 8, 10, 12].map((int number){
              return DropdownMenuItem<int>(
                value: number,
                child: Text('$number Stunden'),
              );
              }
            ),
          ],
          dropdownStyleData: DropdownStyleData(
            width: null,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).dropdownMenuTheme.inputDecorationTheme?.fillColor ?? Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor,
                  blurRadius: 6,
                  offset: Offset(0, 3)
                )
              ]
            )
          ),
          menuItemStyleData: MenuItemStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16)
          ),
          buttonStyleData: ButtonStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16)
          ),
        ),
      ),
    );
  }
}
