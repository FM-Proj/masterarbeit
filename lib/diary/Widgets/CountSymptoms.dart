import 'package:dietitian_dashboard/diary/diary_display.dart';
import 'package:flutter/material.dart';

class CountSymptoms extends StatefulWidget{
  final List<MealsAndSymptoms> finalTable;
  final DateTime? startDate;
  final DateTime? endDate;

  const CountSymptoms({
    super.key,
    required this.finalTable,
    required this.startDate,
    required this.endDate
    });

    @override
    State<CountSymptoms> createState() => _CountSymptomsState();
}

class _CountSymptomsState extends State<CountSymptoms>{

  late List<MealsAndSymptoms> finalTable;
  late DateTime startDate;
  late DateTime endDate;
  

  @override
  void initState(){
    super.initState();
    finalTable = widget.finalTable;
    startDate = widget.startDate ?? finalTable[0].dateTime;
    endDate = widget.endDate ?? DateTime.now();
  }
  
  @override
  Widget build(BuildContext context){

    // make list of all Symptoms, and there occurances
    List<(String, int)> allSymptoms = [];

    for(var entry in finalTable){

      if(entry.isSymptom && entry.dateTime.isAfter(DateTime(startDate.year, startDate.month, startDate.day)) && entry.dateTime.isBefore(DateTime(endDate.year, endDate.month, endDate.day).add(Duration(days: 1)))){
        
        //check if already in list
        bool notInList = true;


        for(var i = 0; i < allSymptoms.length; i++){
          // if found in list, then increase count and set bool to list
          if(allSymptoms[i].$1 == entry.text){
            notInList = false;

            allSymptoms[i] = (allSymptoms[i].$1, allSymptoms[i].$2 + 1);
          }
        }

        if(notInList){
          // if not in list, then add to list
          allSymptoms.add((entry.text, 1));
        }
      }
    }

    // sort list by most to least occurances
    allSymptoms.sort((a, b) => b.$2.compareTo(a.$2));

    // pre build the table rows
    List<TableRow> rows = [];
    for(var row in allSymptoms){
      rows.add(
        TableRow(
          children: [
            Text(
              row.$1,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              row.$2.toString(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ]
        )
      );
    }

    // get the total number of symptoms
    int totalSymptomCount = 0;
    for(var sympt in allSymptoms){
      totalSymptomCount += sympt.$2;
    }
    
    return Container(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerTheme: DividerThemeData(
              color: Colors.transparent
            )
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 20, top: 10),    // for better optics, add padding on left and top
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(2), // 3/4 of space
                1: FlexColumnWidth(1)  // 1/4 of space
              },
              children: [
                TableRow(
                  children: [
                    Text(
                      "Symptom",
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      "Anzahl",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ]
                ),
                TableRow(children: [SizedBox(height: 10,), SizedBox(height: 10,)]), // empty row for space
                TableRow(children: [Text("(Insgesamt)", textAlign: TextAlign.left,), Text("($totalSymptomCount)", textAlign: TextAlign.center,)]), // One row as a summary
                ...rows   // add generated rows
              ],
            ),
          ),
        ),
      ),
    );
  }
}