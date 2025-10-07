import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

class DateSelector extends StatefulWidget{
  final List<DateTime> allDatesLogged;
  final List<DateTime> symptomDays;
  final void Function(DateTime? start, DateTime? end) updateCalender;
  final String Function(DateTime? startD, DateTime? endD) makeDisplayedText;

  const DateSelector({
    super.key,
    required this.allDatesLogged,
    required this.symptomDays,
    required this.updateCalender,
    required this.makeDisplayedText
    });

    @override
    State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector>{

  late List<DateTime> allDatesLogged;
  late List<DateTime> symptomDays;
  late void Function(DateTime? start, DateTime? end) updateCalender;
  late String Function(DateTime? startD, DateTime? endD) makeDisplayedText;
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState(){
    super.initState();
    allDatesLogged = widget.allDatesLogged;
    symptomDays = widget.symptomDays;
    updateCalender = widget.updateCalender;
    makeDisplayedText = widget.makeDisplayedText;
  }
  
  @override
  Widget build(BuildContext context){
    
    // If dates not filled yet, then set to standard
    // use first value of sorted list (first day with logged data) & current day
    startDate ??= allDatesLogged[0];
    DateTime now = DateTime.now();
    endDate ??= DateTime(now.year, now.month, now.day);

    // List of dates selected in calenderpicker
    List<DateTime?> selectedDates = [];
    List<DateTime?> tempDates = [];

    // display text to first day to today
    Future<void> popUpCalender(BuildContext context) async {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(15), //TODO
            content: SizedBox(
              width: double.maxFinite,
              child: CalendarDatePicker2WithActionButtons(
                config: CalendarDatePicker2WithActionButtonsConfig(
                  firstDate: allDatesLogged[0],
                  lastDate: now,
                  firstDayOfWeek: 1,
                  dayTextStyle: Theme.of(context).datePickerTheme.dayStyle,
                  //TODO selectedRangeDayTextStyle: Theme.of(context).datePickerTheme.rangePickerHeaderHelpStyle,
                  yearTextStyle: Theme.of(context).datePickerTheme.yearStyle,
                  weekdayLabelTextStyle: Theme.of(context).datePickerTheme.weekdayStyle,
                  calendarType: CalendarDatePicker2Type.range,
                  dayBuilder:({required date, decoration, isDisabled, isSelected, isToday, textStyle}) {
                    final hadSymptomOnThisDay = symptomDays.contains(DateTime(date.year, date.month, date.day));
                    
                    return Container(
                      alignment: Alignment.center,
                      decoration: isSelected! ? BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor
                        )
                        : BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).datePickerTheme.backgroundColor
                        ),
                      child: Text(
                        "${date.day}",
                        style: TextStyle(
                          color: hadSymptomOnThisDay ? Colors.red : (isDisabled! ? Colors.grey : Colors.black),
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    );
                  } ,
                ), 
                value: selectedDates,
                onValueChanged: (dates){
                    tempDates = dates;
                },
                onOkTapped: () {
                  setState(() {
                    selectedDates = tempDates;

                    //if only one day was selected
                    if(selectedDates.length == 1){
                      startDate = selectedDates[0];
                      endDate = selectedDates[0];
                    }
                    else{
                      startDate = selectedDates[0];
                      endDate = selectedDates[1];
                    }
                  });
                  updateCalender(startDate, endDate);
                  Navigator.of(context).pop();
                },
                onCancelTapped: (){
                  Navigator.of(context).pop();
                },
              ),
            ),
          );
        }
      );
    }

    // Return widget
    return GestureDetector(
      onTap: () {
        popUpCalender(context); 
      },

      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),  //TODO
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),   // TODO
          borderRadius: BorderRadius.circular(15)
        ),

        child: Text(
          makeDisplayedText(startDate, endDate),
          style: TextStyle(
            fontWeight: FontWeight.bold, //TODO
            color: Theme.of(context).primaryColor
          ),
          textAlign: TextAlign.center,
        ),
      )
    );
  }
}