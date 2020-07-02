import 'dart:async';
import 'dart:convert';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zoom_get_coordinate/sizeConfig.dart';
import 'package:flutter/material.dart';

import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:zoom_get_coordinate/src/function/dbHelp.dart';
import 'package:zoom_get_coordinate/src/function/startup.dart';
import 'package:zoom_get_coordinate/src/pages/autoBuilder.dart';
import 'package:zoom_get_coordinate/src/pages/home_page.dart';
import 'package:zoom_get_coordinate/src/pages/navigation.dart';
import 'package:zoom_get_coordinate/src/providers/db_provider.dart';
import 'package:zoom_get_coordinate/src/providers/employee_api_provider.dart';


var dataPeriodic = ["Hour", "Day", "Week", "Month", "year"];
var arrayDB = ['minutes', 'hourly', 'daily', 'month', 'year'];
int changeDB = 2;
int changeTime = 1;
var dt = DateTime.now();
var newDt = DateFormat.yMMMEd().format(dt);

var data_tinggi = SizeConfig.blockSizeVertical * 8;
int data_lebar = 200;

var widthbar = SizeConfig.blockSizeHorizontal * 93;
var heightbar = SizeConfig.blockSizeVertical * 10;
var jsonData = '{ "textStyle" : {fontSize: 10,}}';
var parsedJson = json.decode(jsonData);
var red = "#db0202";
var green = "#24CC33";
var black = "#404040";
var blue = "#059AFF";

List totalData =
    List(); //= [94850090.0, 792102930.0, 783312080.0, 966695270.0, 286327720.0, 283805780.0, 1028113750.0, 1164317710.0, 910159550.0, 1044707800.0, 865725660.0, 241664540.0, 223389330.0, 693932270.0, 1076159130.0, 758864820.0, 963988800.0, 262695860.0, 235395120.0, 271740360.0, 777390050.0, 870827320.0, 792580010.0, 753650080.0, 774117540.0, 829522440.0, 873223070.0, 572646200.0];

var xAxisData = [
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22,
  23,
  24
];
var data1 = [
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0
];

var data2 = [
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0
];

var data3 = [
  35,
  40,
  45,
  35,
  35,
  35,
  30,
  25,
  25,
  25,
  23,
  25,
  23,
  25,
  25,
  25,
  25,
  25,
  25,
  25,
  25,
  27,
  25,
  25
];

var data4 = [40, 25, 30, 21, 10, 10];
bool DbStatus = true;
bool timerBuild = true;

class MainPage extends StatelessWidget {
  static const int NUM_ELEMENTS = 50;
  static const int ON_SCREEN = 10;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

 _timerBuild() {
    Timer.periodic(Duration(seconds: 2), (timer) async {
      var dataLastDaily = await  StartupClass().StartgetdateNow("daily");
      if(dataLastDaily){
        setState(() {
          
        });

        await Future.delayed(const Duration(seconds: 5));
        timer.cancel();
      }
    });
  }

  _startUpCheck() async {
    var data = await StartupClass().StartgetdateNow("daily");

    print("Last Data : " + data.toString());
  }

  bool myInterceptor(bool stopDefaultButtonEvent) {
    print("BACK BUTTON!"); // Do some stuff.
    return true;
  }

  @override
  void initState() {

    _startUpCheck();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return Scaffold(

        backgroundColor: Colors.white,
        body: DbStatus
            ? Stack(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: SizeConfig.blockSizeVertical * 2,
                        width: SizeConfig.blockSizeHorizontal * 0,
                      ),
                      Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {

                                  _timerBuild();
                                  setState(() {
                                    
                                  });
                                }),
                            IconButton(
                                icon: Icon(Icons.file_download),
                                onPressed: () {
                                  _startUpCheck();

                                  print("panjang Json : "+EmployeeApiProvider().getlengthdata().toString());

                                }),
                          ],
                        ),
                      ),
                      Center(
                        child: Text(
                          '$newDt',
                          style: GoogleFonts.openSans(
                            fontSize: 20,
                          ),
                          textScaleFactor: 1,
                        ),
                      ),
                      Stack(
                        children: <Widget>[
                    //   Center(
                    //   child: Container(
                    //     width: SizeConfig.blockSizeHorizontal * 70,
                    //     height: SizeConfig.blockSizeVertical * 22,
                    //     // width: 200,
                    //     child: Image.asset(
                    //       'asset/linefix.png',
                    //     ),
                    //   ),
                    // ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    height: SizeConfig.blockSizeVertical * 2,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 7),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(36, 204, 51, 0.8),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      height: SizeConfig.blockSizeVertical * 5,
                                      width: SizeConfig.blockSizeHorizontal * 45,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              'Harvest',
                                              style: GoogleFonts.openSans(
                                                  fontSize: 15,
                                                  color: Colors.white),
                                              textScaleFactor: 1,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 10),
                                            child: Text(
                                              '30%',
                                              style: GoogleFonts.openSans(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                              textScaleFactor: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: SizeConfig.blockSizeVertical * 1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 7),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.lightBlue,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      height: SizeConfig.blockSizeVertical * 5,
                                      width: SizeConfig.blockSizeHorizontal * 45,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              'Store',
                                              style: GoogleFonts.openSans(
                                                  fontSize: 15,
                                                  color: Colors.white),
                                              textScaleFactor: 1,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 10),
                                            child: Text(
                                              '19%',
                                              style: GoogleFonts.openSans(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                              textScaleFactor: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: SizeConfig.blockSizeVertical * 1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 7),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[800],
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      height: SizeConfig.blockSizeVertical * 5,
                                      width: SizeConfig.blockSizeHorizontal * 45,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              'PLN',
                                              style: GoogleFonts.openSans(
                                                  fontSize: 15,
                                                  color: Colors.white),
                                              textScaleFactor: 1,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 10),
                                            child: Text(
                                              '51%',
                                              style: GoogleFonts.openSans(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                              textScaleFactor: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: SizeConfig.blockSizeVertical * 7,
                                  ),
                                ],
                              ),
                              Container(
                                width: SizeConfig.blockSizeHorizontal * 4,
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    // decoration: BoxDecoration(color: Colors.green),
                                    height: SizeConfig.blockSizeVertical * 1,
                                    width: SizeConfig.blockSizeHorizontal * 1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: InkWell(
                                      onTap: () async {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => HomePage()));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        height: SizeConfig.blockSizeVertical * 17.5,
                                        width: SizeConfig.blockSizeHorizontal * 45,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 10),
                                              child: Text(
                                                'Enjoy',
                                                style: GoogleFonts.openSans(
                                                    fontSize: 21,
                                                    color: Colors.white),
                                                textScaleFactor: 1,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      bottom: 10),
                                                  child: Text(
                                                    '20',
                                                    style: GoogleFonts.openSans(
                                                        fontSize: 23,
                                                        color: Colors.white),
                                                    textScaleFactor: 1,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      bottom: 10),
                                                  child: Text(
                                                    ' kwh',
                                                    style: GoogleFonts.openSans(
                                                        fontSize: 18,
                                                        color: Colors.white),
                                                    textScaleFactor: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                          // ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),

                      Container(
                        child: Echarts(
                          option: '''
                    {
                animation:false,
                height:'$data_tinggi',
              
                grid: {
                         left: '0px',
                        right: '0px',
                       
                        top:'0px'
                      },
               
                xAxis: {
                        type: 'category',

                       
                       
                        show: false,                         
                        },
                yAxis: {
                    type: 'value',
                    show: false,  
                    max: 50,
               
                    
                   
                        },

                series: [{
                    
                    data: $data2,
                    type: 'bar',
                    itemStyle: {color: '$green'},
                    showBackground: true,
                    backgroundStyle: {
                        color: '#ffffff'
                    }
                    
                }]

              }
              
                ''',
                        ),
                        width: widthbar,
                        height: heightbar,
                      ),
                      Container(
                        child: Echarts(
                          option: '''
                  {
              animation:false,
              height:'$data_tinggi',
              
              grid: {
                      left: '0px',
                      right: '0px',
                     
                      top:'0px'
                    },
               
              xAxis: {
                      type: 'category',

                     
                     
                      show: false,                         
                      },
              yAxis: {
                  type: 'value',
                  show: false,  
                  inverse: false,
                 
                  
                 
                      },

              series: [{
                  
                  data: $totalData,
                  type: 'bar',
                  itemStyle: {color: '$black'},
                  showBackground: true,
                  backgroundStyle: {
                      color: '#ffffff'
                  }
                  
              }]

              }
              
              ''',
                        ),
                        width: widthbar,
                        height: heightbar,
                      ),
                      Container(
                        child: Echarts(
                          option: '''
                    {
                animation:false,
                height:'$data_tinggi',
              
                grid: {
                        left: '0px',
                        right: '0px',
                       
                        top:'0px'
                      },
               
                xAxis: {
                        type: 'category',

                       
                       
                        show: false,                         
                        },
                yAxis: {
                    type: 'value',
                    show: false,  
                    inverse: true,
                   
                    
                   
                        },

                series: [{
                    
                    data: $totalData,
                    type: 'bar',
                    itemStyle: {color: '$red'},
                    showBackground: true,
                    backgroundStyle: {
                        color: '#ffffff'
                    }
                    
                }]

              }
              
                ''',
                        ),
                        width: widthbar,
                        height: heightbar,
                      ),
                      Container(
                        child: Echarts(
                          option: '''
                    {
                animation:false,
                height:'$data_tinggi',
              
                grid: {
                        left: '0px',
                        right: '0px',
                        top:'0px'
                      },
               
                xAxis: {
                        type: 'category',

                       
                       
                        show: false,                         
                        },
                yAxis: {
                    type: 'value',
                    show: false,
                    max: 50,  
               
                    
                   
                        },

                series: [{
                    
                    data: $data1,
                    type: 'bar',
                    itemStyle: {color: '$blue'},
                    showBackground: true,
                    backgroundStyle: {
                        color: '#ffffff'
                    }
                    
                }]

              }
              
                ''',
                        ),
                        width: widthbar,
                        height: heightbar,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      navButton(false),
                      _buildGrapgh(),
                    ],
                  ),
                ],
              )
            : Stack(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Card(
                          child: Image.asset(
                        'assets/images/SundayaLogo.jpg',
                        fit: BoxFit.fitWidth,
                      )),
                      Card(child: Container())
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Card(
                            child: IconButton(
                                icon: Icon(Icons.skip_previous),
                                onPressed: () {
                                  setState(() {
                                    
                                  });
                                }),
                          ),
                          Card(
                            child: IconButton(
                                icon: Icon(Icons.skip_next), onPressed: () {
                                  DbStatus = true;
                                  setState(() {
                                    
                                  });
                                }),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ));
  }

  _buildGrapgh() {
    var queryResult = DBProvider.db.getAllData("daily");

    if (queryResult == null) {
      return SpinKitWave(
                    color: Colors.blue,
                    size: 50.0,
                  );
    } else {
      return FutureBuilder(
          future: queryResult,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {

            List energyTotal = new List();
            for (int i = 0; i < snapshot.data.length; i++) {
              energyTotal.add(snapshot.data[i]['energy_total'].toString());
            }
            totalData = energyTotal;
            return Text("datax");
            }

          });
    }
  }

  Widget navButton(bool navStatus) {
    if (navStatus) {
      return Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Card(
                  child: IconButton(
                      icon: Icon(Icons.keyboard_arrow_left),
                      highlightColor: Colors.grey,
                      onPressed: () async {
                        print("ambil data daily");
                        var lastData = await DBProvider.db.checkLastDB("daily");
                        if (lastData == "") {
                          EmployeeApiProvider().getPartialdata("", "", "daily");
                        } else {
                        }

                        setState(() {});
// BuildBar();
                        print("left");
                        // queryAll("left");
                      }),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Card(
                      child: IconButton(
                          icon: Icon(Icons.keyboard_arrow_up),
                          highlightColor: Colors.grey,
                          onPressed: () {
                            setState(() {
                              changeTime++;
                              _startUpCheck();

                            });
                          }),
                    ),
                    Text(
                      '$changeTime',
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      textScaleFactor: 1,
                    ),
                    Card(
                      child: IconButton(
                          icon: Icon(Icons.keyboard_arrow_down),
                          highlightColor: Colors.grey,
                          onPressed: () {
                            setState(() {
                              changeTime--;
                              if (changeTime < 1) changeTime = 1;

                            });
                          }),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Card(
                      child: IconButton(
                          icon: Icon(Icons.keyboard_arrow_up),
                          highlightColor: Colors.red,
                          onPressed: () {

                            setState(() {
                              changeDB++;
                              if (changeDB > arrayDB.length - 1) {
                                changeDB = arrayDB.length - 1;
                              }
                            });
                          }),
                    ),
                    Text(
                      arrayDB[changeDB],
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      textScaleFactor: 1,
                    ),
                    Card(
                      child: IconButton(
                          icon: Icon(Icons.keyboard_arrow_down),
                          highlightColor: Colors.red,
                          onPressed: () {
                            setState(() {
                              changeDB--;
                              if (changeDB < 0) {
                                changeDB = 0;
                              }
                            });
                          }),
                    ),
                  ],
                ),
              ),
              Container(
                child: Card(
                  child: IconButton(
                      icon: Icon(Icons.keyboard_arrow_right),
                      highlightColor: Colors.grey,
                      onPressed: () async {
                        print("kanan");
                        var lastData = await DBProvider.db.checkLastDB("daily");
                        print("Last data : " + lastData.toString());
                        setState(() {});
                      }),
                ),
              ),
            ],
          ),
        ],
      );
    } 
    else {
      return Center(child: Text("Download Data"));
    }
  }
}

Widget _myListView(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Card(
            child: Container(
              height: SizeConfig.blockSizeVertical * 8,
              width: SizeConfig.blockSizeHorizontal * 15,
              child: ListView.separated(
                itemCount: 999,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Center(
                        child: Text(
                      (index + 1).toString(),
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(fontSize: 16)),
                      textScaleFactor: 1,
                    )),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
