import 'package:dietitian_dashboard/diary/diary_display.dart';
import 'package:flutter/material.dart';

class PatientID {
  final String? name;
  final String? birthday;
  final List<String>? previousDiagnoses;
  final List<List<String>> previousIntoleranceTests; 
  final List<String>? foodsLeftOut;
  final List<String> symptomsLastTwoWeeks;

  PatientID({
    required this.name,
    required this.birthday,
    required this.previousDiagnoses,
    required this.previousIntoleranceTests, 
    required this.foodsLeftOut,
    required this.symptomsLastTwoWeeks
  });
}

// Just calls the pop up window
Future<void> showPopUpPatientInfo(BuildContext context, String authenticationUserId, List<MealsAndSymptoms> finalTable){
  return showDialog(
    context: context, 
    builder: (_) => PatientInformation(authenticationUserId: authenticationUserId, finalTable: finalTable,)
  );
}

class PatientInformation extends StatefulWidget{
  final String? authenticationUserId;
  final List<MealsAndSymptoms> finalTable;
  final String? name;
  // TODO: Ändern? final DateTime? birthday;
  final String? birthday;
  final List<String>? previousDiagnoses;
  final List<List<String>>? previousIntoleranceTests; 
  final List<String>? foodsLeftOut;

  const PatientInformation({
    super.key,
    required this.authenticationUserId,
    required this.finalTable,
    this.name,
    this.birthday,
    this.foodsLeftOut,
    this.previousDiagnoses,
    this.previousIntoleranceTests,
    });

    @override
    State<PatientInformation> createState() => _PatientInformationState();
}

class _PatientInformationState extends State<PatientInformation>{
  late String? authenticationUserId;
  late List<MealsAndSymptoms> finalTable;
  late String? name;
  // TODO: Ändern? late DateTime? birthday;
  late String? birthday;

  List<String> symptomsLastTwoWeeks = [];
  List<String>? previousDiagnoses;
  List<List<String>> previousIntoleranceTests = []; 
  List<String>? foodsLeftOut;

  // Variables for later
  List<List<String>> table = [];
  List<String> labels = [
    "Name",
    "Geburtsdatum",
    "Symptome (lezten 14 Tage)",
    "Vorherige Diagnosen",
    "Vergangene Unverträglichkeits-Tests",
    "Aktuelle verzichtete Lebensmittel"
  ];
  List<String> values = []; // filled in initState


  @override
  void initState(){
    super.initState();
    authenticationUserId = widget.authenticationUserId;
    finalTable = widget.finalTable;

    // TODO START for all: if null, then fetch from authentificatioUserId
    // id = get(userID)
    List<PatientID> ids = [
     PatientID(
      name: "Max Mustermann",
      birthday: "17.05.1987",
      previousDiagnoses: ["Laktoseintoleranz", "Gallenprobleme"],
      previousIntoleranceTests: [["01.01.2003", "Laktosetest"], ["04.06.2017", "Darmspiegelung"], ["03.03.2025", "Fruktosetest"]],
      foodsLeftOut: ["Laktose"],
      symptomsLastTwoWeeks: []
    ),
     PatientID(
      name: "Maxine Musterfrau",
      birthday: "17.05.1987",
      previousDiagnoses: ["Laktoseintoleranz"],
      previousIntoleranceTests: [],
      foodsLeftOut: ["Laktose"],
      symptomsLastTwoWeeks: []
    ),
     PatientID(
      name: "Maxine Musterfrau",
      birthday: "17.05.1987",
      previousDiagnoses: [],
      previousIntoleranceTests: [["01.01.2003", "Laktosetest"]],
      foodsLeftOut: [],
      symptomsLastTwoWeeks: []
    )
    ];
    
    var ind = 0;
    name = ids[ind].name;
    birthday = ids[ind].birthday;
    previousDiagnoses = ids[ind].previousDiagnoses;
    previousIntoleranceTests = ids[ind].previousIntoleranceTests;
    foodsLeftOut = ids[ind].foodsLeftOut;
    symptomsLastTwoWeeks = ids[ind].symptomsLastTwoWeeks;

/*
    name = widget.name;         
    birthday = widget.birthday;
    previousDiagnoses = widget.previousDiagnoses ?? /*TODO: authUserId.symptomsLastTwoWeeks.isEmpty ?? */ [];
    previousIntoleranceTests = widget.previousIntoleranceTests ?? /*TODO: authUserId.symptomsLastTwoWeeks.isEmpty ?? */ [];
    foodsLeftOut = widget.foodsLeftOut ?? /*TODO: authUserId.symptomsLastTwoWeeks.isEmpty ?? */ [];
    // TODO END
*/
    DateTime now = DateTime.now();
    now = DateTime(now.year, now.month, now.day); // remove time
    for(var elem in finalTable){
      if(elem.isSymptom && elem.dateTime.isAfter(now.subtract(Duration(days: 14))) && !symptomsLastTwoWeeks.contains(elem.text)){
        symptomsLastTwoWeeks.add(elem.text);
      }
    }


    // fill values List
    values = [
      name.toString(),
      birthday.toString(), //TODO nötig? -> DateFormat("dd.MM.yyyy").format(birthday!).toString(),
      symptomsLastTwoWeeks.map((i) => i).join(", "),
      previousDiagnoses!.map((i) => i).join(", "),
      previousIntoleranceTests.map((i) => "${i[0]}: ${i[1]}" ).join("\n"),
      foodsLeftOut!.map((i) => i).join(", "),
    ];

    // fill List for Table
    for(var i=0; i < values.length; i++){
      table.add([labels[i], values[i]]);
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

  List<double> widths = [0.0, 0.0];
  for(var i = 0; i<table.length; i++){
    if(measureWidthOfValue(table[i][0].toString(), context) > widths[0]){
      widths[0] = measureWidthOfValue(table[i][0].toString(), context);
    }
    if(measureWidthOfValue(table[i][1].toString(), context) > widths[1]){
      widths[1] = measureWidthOfValue(table[i][1].toString(), context);
    }
  }
    
    return AlertDialog(
      contentPadding: EdgeInsets.all(15), //TODO
      content: SizedBox(
        //width: double.maxFinite,
        width: widths[0] + widths[1],           //TODO: final width?
        height: 400,                             //TODO: final heigth?
        child: SingleChildScrollView(
          child: Column(
            children: [
              Table(
                //columnWidths: const{ 0: IntrinsicColumnWidth(), 1: IntrinsicColumnWidth()},
                children: table.map((row){
                  return TableRow(
                    children: [
                      Padding(padding: const EdgeInsets.all(8), child: Text(row[0] + ":"),),    //TODO: style
                      Padding(padding: const EdgeInsets.all(8), child: Text(row[1]),), //TODO: style
                    ]
                  );
                }).toList(),
              ),
            ]
          ),
        ),
      ),

      // Close Button in top right corner
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(), 
            icon: Icon(Icons.close)
          )
        ],
      ),
      
    ); 
  }
}