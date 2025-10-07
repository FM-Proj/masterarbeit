import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarDiagram extends StatefulWidget{
  final List<(String, int, int)> barData;

  const BarDiagram({
    super.key,
    required this.barData,
    });

    @override
    State<BarDiagram> createState() => _BarDiagramState();
}

class _BarDiagramState extends State<BarDiagram>{

  late List<(String, int, int)> barData;
  

  @override
  void initState(){
    super.initState();
    barData = widget.barData;
  }
  
  @override
  Widget build(BuildContext context){

    // catch in case entry data not valid yet
    if(barData.isEmpty){
      return Center(
        child: Text(
          "Bitte ein Zeitfenster auswählen",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,),
          )
        );
    }
    
    // create values for donut charts
    double totalElevatedGluten = 0;
    double withoutSymptomGluten = 0;
    double withSymptomGluten = 0;

    double totalElevatedFructose = 0;
    double withoutSymptomFructose = 0;
    double withSymptomFructose = 0;

    double totalElevatedLactose = 0;
    double withoutSymptomLactose = 0;
    double withSymptomLactose = 0;

    double totalElevatedSorbitol = 0;
    double withoutSymptomSorbitol = 0;
    double withSymptomSorbitol = 0;

    for(var entry in barData){
      if(entry.$1 == "Gluten"){
        totalElevatedGluten = entry.$3.toDouble();
        withoutSymptomGluten = entry.$2.toDouble();
        withSymptomGluten = (totalElevatedGluten - withoutSymptomGluten);
      }

      if(entry.$1 == "Fruktose"){
        totalElevatedFructose = entry.$3.toDouble();
        withoutSymptomFructose = entry.$2.toDouble();
        withSymptomFructose = (totalElevatedFructose - withoutSymptomFructose);
      }

      if(entry.$1 == "Laktose"){
        totalElevatedLactose = entry.$3.toDouble();
        withoutSymptomLactose = entry.$2.toDouble();
        withSymptomLactose = (totalElevatedLactose - withoutSymptomLactose);
      }

      if(entry.$1 == "Sorbitol"){
        totalElevatedSorbitol = entry.$3.toDouble();
        withoutSymptomSorbitol = entry.$2.toDouble();
        withSymptomSorbitol = (totalElevatedSorbitol - withoutSymptomSorbitol);
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Row(
            children: [
              SizedBox(
                width: 100, 
                child: Text("Fruktose: ")
              ),
              Expanded(
                child: Stack(
                  children: [
                    RotatedBox(  // Barchart is upright, so turn to side here
                      quarterTurns: 1,
                      child: BarChart(
                        BarChartData(
                          maxY: 100,
                          minY: 0,
                          gridData: FlGridData(show: false),
                          borderData: FlBorderData(show: false),
                          titlesData: FlTitlesData(show: false),
                          barGroups: [
                            BarChartGroupData(
                              x: 0,   // barchart: from 0%
                              barRods: [
                                BarChartRodData(
                                  toY: 100,     // barchart: to 100%
                                  width: 20,
                                  rodStackItems: [
                                    BarChartRodStackItem(0, ((withSymptomFructose/totalElevatedFructose)*100).ceil().toDouble(), Colors.red),
                                    BarChartRodStackItem(((withSymptomFructose/totalElevatedFructose)*100).ceil().toDouble(), 100, Colors.green)
                                  ]
                                )
                              ]
                            )
                          ]
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        // only show Text if not 0%
                        child: Text(withSymptomFructose == 0 ? "" : "$withSymptomFructose/$totalElevatedFructose (${((withSymptomFructose/totalElevatedFructose)*100).ceil()}%)")
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Align(
                        alignment: Alignment.centerRight,
                        // only show Text if not 0%
                        child: Text(withoutSymptomFructose == 0 ? "" : "(${((withoutSymptomFructose/totalElevatedFructose)*100).floor()}%) $withoutSymptomFructose/$totalElevatedFructose")
                      ),
                    ),
                  ],
                )
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              SizedBox(
                width: 100, 
                child: Text("Laktose: ")
              ),
              Expanded(
                child: Stack(
                  children: [
                    RotatedBox(  // Barchart is upright, so turn to side here
                      quarterTurns: 1,
                      child: BarChart(
                        BarChartData(
                          maxY: 100,
                          minY: 0,
                          gridData: FlGridData(show: false),
                          borderData: FlBorderData(show: false),
                          titlesData: FlTitlesData(show: false),
                          barGroups: [
                            BarChartGroupData(
                              x: 0,   // barchart: from 0%
                              barRods: [
                                BarChartRodData(
                                  toY: 100,     // barchart: to 100%
                                  width: 20,
                                  rodStackItems: [
                                    BarChartRodStackItem(0, ((withSymptomLactose/totalElevatedLactose)*100).ceil().toDouble(), Colors.red),
                                    BarChartRodStackItem(((withSymptomLactose/totalElevatedLactose)*100).ceil().toDouble(), 100, Colors.green)
                                  ]
                                )
                              ]
                            )
                          ]
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        // only show Text if not 0%
                        child: Text(withSymptomLactose == 0 ? "" : "$withSymptomLactose/$totalElevatedLactose (${((withSymptomLactose/totalElevatedLactose)*100).ceil()}%)")
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Align(
                        alignment: Alignment.centerRight,
                        // only show Text if not 0%
                        child: Text(withoutSymptomLactose == 0 ? "" : "(${((withoutSymptomLactose/totalElevatedLactose)*100).floor()}%) $withoutSymptomLactose/$totalElevatedLactose")
                      ),
                    ),
                  ],
                )
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              SizedBox(
                width: 100, 
                child: Text("Sorbit: ")
              ),
              Expanded(
                // use stack to add labels to the barchart
                child: Stack( 
                  alignment: Alignment.center,
                  children: [
                    RotatedBox(  // Barchart is upright, so turn to side here
                      quarterTurns: 1,
                      // Barchart
                      child: BarChart(
                        BarChartData(
                          maxY: 100,
                          minY: 0,
                          gridData: FlGridData(show: false),
                          borderData: FlBorderData(show: false),
                          titlesData: FlTitlesData(show: false),
                          barGroups: [
                            BarChartGroupData(
                              x: 0,   // barchart: from 0%
                              barRods: [
                                BarChartRodData(
                                  toY: 100,     // barchart: to 100%
                                  width: 20,
                                  rodStackItems: [
                                    BarChartRodStackItem(0, ((withSymptomSorbitol/totalElevatedSorbitol)*100).ceil().toDouble(), Colors.red),
                                    BarChartRodStackItem(((withSymptomSorbitol/totalElevatedSorbitol)*100).ceil().toDouble(), 100, Colors.green)
                                  ]
                                )
                              ]
                            )
                          ]
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        // only show Text if not 0%
                        child: Text(withSymptomSorbitol == 0 ? "" : "$withSymptomSorbitol/$totalElevatedSorbitol (${((withSymptomSorbitol/totalElevatedSorbitol)*100).ceil()}%)")
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Align(
                        alignment: Alignment.centerRight,
                        // only show Text if not 0%
                        child: Text(withoutSymptomSorbitol == 0 ? "" : "(${((withoutSymptomSorbitol/totalElevatedSorbitol)*100).floor()}%) $withoutSymptomSorbitol/$totalElevatedSorbitol")
                      ),
                    ),
                  ],
                )
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 100, 
                child: Text("Gluten: ")
              ),
              Expanded(
                child: Stack(
                  children: [
                    RotatedBox(  // Barchart is upright, so turn to side here
                      quarterTurns: 1,
                      child: BarChart(
                        BarChartData(
                          maxY: 100,
                          minY: 0,
                          gridData: FlGridData(show: false),
                          borderData: FlBorderData(show: false),
                          titlesData: FlTitlesData(show: false),
                          barGroups: [
                            BarChartGroupData(
                              x: 0,   // barchart: from 0%
                              barRods: [
                                BarChartRodData(
                                  toY: 100,     // barchart: to 100%
                                  width: 20,
                                  rodStackItems: [
                                    BarChartRodStackItem(0, ((withSymptomGluten/totalElevatedGluten)*100).ceil().toDouble(), Colors.red),
                                    BarChartRodStackItem(((withSymptomGluten/totalElevatedGluten)*100).ceil().toDouble(), 100, Colors.green)
                                  ]
                                )
                              ]
                            )
                          ]
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        // only show Text if not 0%
                        child: Text(withSymptomGluten == 0 ? "" : "$withSymptomGluten/$totalElevatedGluten (${((withSymptomGluten/totalElevatedGluten)*100).ceil()}%)")
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Align(
                        alignment: Alignment.centerRight,
                        // only show Text if not 0%
                        child: Text(withoutSymptomGluten == 0 ? "" : "(${((withoutSymptomGluten/totalElevatedGluten)*100).floor()}%) $withoutSymptomGluten/$totalElevatedGluten")
                      ),
                    ),
                  ],
                )
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          "Überschreitung der Schwellenwerte innerhalb des Zeitfensters",
                          overflow: TextOverflow.ellipsis,),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            color: Colors.red,
                          ),
                          Text(" mit Symptome"),
                        ],
                      ),
                      SizedBox(width: 10,),
                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            color: Colors.green,
                          ),
                          Text(" ohne Symptome"),
                        ],
                      ),
                    ],
                  ),
                ],
              )
            ),
            
          ]
        ),
      ],
    );
  }
}