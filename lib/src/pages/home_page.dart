import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:google_fonts/google_fonts.dart';
import 'package:zoom_get_coordinate/sizeConfig.dart';
import 'package:zoom_get_coordinate/src/function/getDateTime.dart';
import 'package:zoom_get_coordinate/src/function/storage.dart';
import 'package:zoom_get_coordinate/src/function/toastInformation.dart';
import 'package:zoom_get_coordinate/src/pages/downloadpage.dart';
import 'package:zoom_get_coordinate/src/pages/usage_widgets.dart';
import 'package:zoom_get_coordinate/src/providers/db_provider.dart';
import 'package:zoom_get_coordinate/src/providers/employee_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:f_datetimerangepicker/f_datetimerangepicker.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:zoom_get_coordinate/src/pages/getDate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:screen/screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

String DataStop = "20200428T110000";
String DataStop1 = ""; //20200414T160000
var GeserStatus = false;
var dateLimit = false;

String dataQuery; //"";
// "SELECT * FROM EMPLOYEE"; //'SELECT * FROM EMPLOYEE WHERE time_stamp BETWEEN "20200428T000000" AND "20200428T010000"';
// 'SELECT * FROM minutes WHERE time_stamp BETWEEN "20200429T000000" AND "20200430T000000"';

String mulai;
String akhir;

String qMulai, qAkhir;

int counter = 1;

List<String> titles = [
  'Phasa A',
  'Phasa B',
  'Phasa C',
];

int dataTinggi = 60;
int dataLebar = 200;

var red = "#db0202";
var data2 = new List();
var panjang = 31;

// ==================== scALE========================//

var StartScale, EndScale, ChangeScale;
var StatusStartScale = false;

// ==================== scALE========================//

int addManual = 0;
int addManualLeft = 1;
double stackHour = 3;

double x = 0.0;
double y = 0.0;

var blue = "#059AFF";

//untuk timer
bool isStopped = false;

int durationTimeGraph = 1100;
var maxData = "500626970";
// untuk timer

bool stateData = false;

String label = "Sedang mengecek database";
String label1 = " no data";
String label2 = " no data";
var iconStatus = Icons.warning;
var colorStatus = Colors.red;

// start data periodic //
var dataPeriodic = ["Hour", "Day", "Week", "Month", "year"];
var arrayDB = ['minutes', 'hourly', 'daily', 'month', 'year'];
int changeDataPeriodic = 0;
// end data periodic //

// start load api json //
var dataCounterApi = 0;
// end load api json //

String timer = "menit";

String timeDisplayStart,
    timeDisplayEnd,
    timestartweek,
    timestartweek1,
    timeendweek,
    timeweekstart,
    timeweekend,
    timestartday,
    timeendday,
    timedaystart,
    timedayend,
    timestarthour,
    timeendhour,
    timehour,
    timehour1;

List timeweeklist = [], timedaylist = [], timehourlist = [];

bool statusMinutes = false;

var maxGrap = 0.0;

//-------//
var dt = DateTime.now();
var newDt = DateFormat.yMMMEd().format(dt);
var dtweek = DateFormat.yMMMM().format(dt);

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;
  var isLoading = false;
  int a = 0;

  void tambah() {
    counter++;
  }

  void incrementCounter() {
    setState(() {
      count++;
    });
  }

  void buildText(String logFile) {
    buildTextLog(logFile);
    setState(() {});
  }

  @override
  void initState() {
    Screen.keepOn(true);
    statusMinutes = true;
    _timerRoutine();

    _CheckLastDB();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: !stateData
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  // child: CircularProgressIndicator(),
                  child: SpinKitWave(
                    color: Colors.blue,
                    size: 50.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(label),
                  // "Tidak ada Database Terdeteksi, silahkan klik update"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(label1), // + "   " + label2),
                  // "Tidak ada Database Terdeteksi, silahkan klik update"),
                ),
              ],
            )
          : SafeArea(
              child: Column(
                children: <Widget>[
                  Text("20"),
                  Container(
                      height: SizeConfig.blockSizeVertical * 37,
                      child: Center(
                        child: _buildEmployeeListView(),
                      )),
                  Container(
                    height: SizeConfig.blockSizeVertical * 1,
                  ),
                  Container(
                    child: selectTime(dataPeriodic[changeDataPeriodic]),
                  ),
                  Expanded(child: Text('')),
                  Center(
                    child: Card(
                      child: ListTile(
                          leading: IconButton(
                              icon: Icon(Icons.delete), onPressed: () {})),
                    ),
                  ),
                  Center(
                    child: Card(
                      child: ListTile(
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Source"),
                            Text(arrayDB[changeDataPeriodic]),
                            // selectTime(arrayDB[changeDataPeriodic]),
                          ],
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text("Start"),
                            Text("End"),
                          ],
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              dateToStr(timeDisplayStart).toString(),
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              // timeDisplayEnd.toString(),
                              dateToStr(timeDisplayEnd).toString(),
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // textScaleFactor: 1,
                  ),
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 2,
                  ),
                ],
              ),
            ),
    );
  }

  Widget buildTextLog(String logFile) {
    return Text(logFile);
  }

  Widget buildTopbutton(String buttonText) {
    return FlatButton(
      child: Text(
        buttonText,
        textScaleFactor: 1.0,
        style: TextStyle(fontSize: 10.0, color: Colors.white),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.white),
      ),
      onPressed: () async {
        String db = buttonText;
        if (buttonText == "minutes") {
          changeDataPeriodic = 0;
          buttonText = "5minutes";
        }

        if (buttonText == "hourly") {
          changeDataPeriodic = 1;
        }

        if (buttonText == "daily") {
          changeDataPeriodic = 2;
        }

        changeQuery1("", "");
      },
    );
  }

  Widget buildNavigator(bool nav) {
    if (nav) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  child: Card(
                    child: IconButton(
                        icon: Icon(Icons.keyboard_arrow_left),
                        highlightColor: Colors.grey,
                        onPressed: () {
                          print("left");
                          queryAll("left");
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
                                addManualLeft++;
                                stackHour = stackHour * 2;
                                // if (addManualLeft > 24) addManualLeft = 24;
                                changeQuery1("data1", "data2");
                              });
                            }),
                      ),
                      Text(
                        addManualLeft.toString(),
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
                                //addManualLeft = 0;
                                addManualLeft--;
                                if (addManualLeft < 1) addManualLeft = 1;
                                (addManualLeft == 1)
                                    ? stackHour = 3.0
                                    : stackHour = (stackHour / 2);
                                changeQuery1("data1", "data2");
                                // addManual = 0;
                              });
                            }),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   // padding: EdgeInsets.all(10),
                //   child: Column(
                //     children: <Widget>[
                //       Card(
                //         child: IconButton(
                //             icon: Icon(Icons.keyboard_arrow_up),
                //             highlightColor: Colors.red,
                //             onPressed: () {
                //               // _checkMaxdb(arrayDB[changeDataPeriodic]);
                //               changeDataPeriodic++;
                //               if (changeDataPeriodic >
                //                   dataPeriodic.length - 1) {
                //                 changeDataPeriodic = dataPeriodic.length - 1;
                //               }
                //               print("changeDataPeriodic " +
                //                   changeDataPeriodic.toString());

                //               setState(() {
                //                 changeQuery1("data1", "data2");
                //               });
                //             }),
                //       ),
                //       Text(
                //         dataPeriodic[changeDataPeriodic],
                //         style: GoogleFonts.openSans(
                //           textStyle: TextStyle(
                //             fontSize: 20,
                //           ),
                //         ),
                //         textScaleFactor: 1,
                //       ),
                //       Card(
                //         child: IconButton(
                //             icon: Icon(Icons.keyboard_arrow_down),
                //             highlightColor: Colors.red,
                //             onPressed: () {
                //               // _checkMaxdb(arrayDB[changeDataPeriodic]);

                //               changeDataPeriodic--;
                //               if (changeDataPeriodic < 0) {
                //                 changeDataPeriodic = 0;
                //               }
                //               setState(() {
                //                 changeQuery1("data1", "data2");
                //               });
                //             }),
                //       ),
                //     ],
                //   ),
                // ),
                Container(
                  // padding: EdgeInsets.all(15),
                  child: Card(
                    child: IconButton(
                        icon: Icon(Icons.keyboard_arrow_right),
                        highlightColor: Colors.grey,
                        onPressed: () {
                          print("kanan");
                          queryAll("right");
                          // _checkMaxdb(arrayDB[changeDataPeriodic]);
                          setState(() {});
                        }),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return downloadData("a");
    }
  }

  selectTime(String periodic) {
    if (periodic == "Week") {
      return UsageWidgets().weekPeriodic();
    } else if (periodic == "Day") {
      return UsageWidgets().dayPeriodic();
    } else if (periodic == "Hour") {
      return UsageWidgets().hourPeriodic();
    } else {}
  }

  changeQuery1(String data1, String data2) async {
    var hourToDays = stackHour / 24;
    if (stackHour < 24) {
      changeDataPeriodic = 0;
    } else if (hourToDays < 32) {
      changeDataPeriodic = 1;
    } else if (hourToDays < 512) {
      changeDataPeriodic = 2;
    } else if (hourToDays >= 512) {
      changeDataPeriodic = 3;
    } else {}
    print("Stack Hour " + stackHour.toString());

    var dataq = await loadlast(arrayDB[changeDataPeriodic]);
    print("Last DB Query : " +
        dataq.toString() +
        " " +
        changeDataPeriodic.toString());
    DateTime tempDate;

    if (dataq != null) {
      stateData = true;
      try {
        tempDate = DateTime.parse(dataq.toString().split(".")[0].toString());

        stateData = true;

        var fiftyDaysFromNow;
        print("tempDate : " + tempDate.toString());
        if (changeDataPeriodic == 0) {
          // fiftyDaysFromNow = tempDate.add(new Duration(hours: -addManualLeft));
          fiftyDaysFromNow =
              tempDate.add(new Duration(hours: -stackHour.round()));
        } else if (changeDataPeriodic == 1) {
          fiftyDaysFromNow =
              tempDate.add(new Duration(hours: -stackHour.round()));
        } else if (changeDataPeriodic == 2) {
          fiftyDaysFromNow =
              tempDate.add(new Duration(days: -hourToDays.round()));
        } else if (changeDataPeriodic == 3) {
          // fiftyDaysFromNow

        }

        var format = DateFormat('yyyyMMddTkk0000')
            .format(fiftyDaysFromNow)
            .toString(); // TODO: error disini

        DateTime dateTimeNow = DateTime.now();

        final differenceInDays = dateTimeNow.difference(tempDate).inHours;
        print("Selisih hour : " + differenceInDays.toString());
        print("awal : " + tempDate.toString());

        data1 = format.replaceAll("T24", "T00");
        format = DateFormat('yyyyMMddTkkmm').format(tempDate).toString();

        DateTime now = new DateTime.now();
        DateTime date =
            new DateTime(now.year, now.month, now.day, now.hour, now.minute);

        DateTime timeStart = DateTime.parse(data1.toString());
        var timeStartFormat =
            new DateFormat('yyyy-MM-dd kk:mm:00').format(timeStart).toString();
        data2 = dataq.toString().split(".")[0].toString();

        data2 = DateFormat('yyyyMMddTkk0000').format(DateTime.parse(data2));
        data2 = data2.replaceAll("T24", "T00");

        // dataa = format.replaceAll("T24", "T00");
        // format = DateFormat('d').format(tempDate).toString();

        print("start date " + data1);
        print(" end date " + data2);
        // print(dataa);

        timeDisplayStart = data1;
        timeDisplayEnd = data2;

        timestartweek = data1;
        timestartweek = DateFormat('dd').format(DateTime.parse(timestartweek));
        if (changeDataPeriodic == 2) {
          timeweeklist =
              getDaysInBetween(DateTime.parse(data1), DateTime.parse(data2));
        }

        // timestartweek1 = data1;
        // timestartweek1 = DateFormat('dd').format(DateTime.parse(timestartweek));
        // int.parse(timestartweek1);

        timeendweek = data2;
        timeendweek = DateFormat('dd').format(DateTime.parse(timeendweek));

        timeweekstart = data1;
        timeweekstart =
            DateFormat('yMMM').format(DateTime.parse(timeweekstart));

        timeweekend = data2;
        timeweekend = DateFormat('yMMM').format(DateTime.parse(timeweekend));

        timestartday = data1;
        timestartday = DateFormat('dd').format(DateTime.parse(timestartday));
        if (changeDataPeriodic == 1) {
          timedaylist =
              getDaysInBetween(DateTime.parse(data1), DateTime.parse(data2));
        }

        timeendday = data2;
        timeendday = DateFormat('dd').format(DateTime.parse(timeendday));

        timedayend = data2;
        timedayend = DateFormat('yMMM').format(DateTime.parse(timedayend));

        timedaystart = data1;
        timedaystart = DateFormat('yMMM').format(DateTime.parse(timedaystart));

        timestarthour = data1;
        timestarthour = DateFormat('kk').format(DateTime.parse(timestarthour));
        if (changeDataPeriodic == 0) {
          timehourlist =
              getHoursInBetween(DateTime.parse(data1), DateTime.parse(data2));
        }

        timeendhour = data2;
        timeendhour = DateFormat('kk').format(DateTime.parse(timeendhour));

        timehour = data1;
        timehour = DateFormat('Hm').format(DateTime.parse(timehour));

        timehour1 = data1;
        timehour1 = DateFormat('yMMMMd').format(DateTime.parse(timehour1));

        DateTime endDate;
        if (changeDataPeriodic == 0) {
          endDate = DateTime.parse(data2.toString().split(".")[0].toString());
        } else {
          endDate = DateTime.parse(data2.toString().split("+")[0].toString());
        }
        timeStartFormat =
            new DateFormat('yyyy-MM-dd kk:mm:00').format(endDate).toString();
        qAkhir = timeStartFormat.toString();
        print("end : " + timeStartFormat.toString());
        String inputQuery = "minutes";
        if (changeDataPeriodic == 1) {
          maxData = "30084800";
          inputQuery = "hourly";
        }
        if (changeDataPeriodic == 0) {
          maxData = "7519920";
          inputQuery = "minutes";
        }
        if (changeDataPeriodic == 2) {
          maxData = "500626970";
          //"112626970"
          inputQuery = "daily";
        }

        setState(() {
          dataQuery =
              'SELECT * FROM $inputQuery WHERE time_stamp BETWEEN "$data1" AND "$data2"';
        });
      } catch (e) {
        print("eror : " + e.toString());
      }
    } else {}
  }

  loadlast(String dbname) async {
    var getlast = await DBProvider.db
        .getLastData("SELECT * FROM $dbname ORDER BY time_stamp DESC LIMIT 1");
    if (getlast != null) {
      var dx = getlast.toList();

      try {
        return dx[0]['time_stamp'].toString();
      } catch (e) {}
    }
  }

  lastDbData(String dbname) async {
    var getlast = await DBProvider.db
        .getLastData("SELECT * FROM $dbname ORDER BY time_stamp DESC LIMIT 1");
    if (getlast != null) {
      var dx = getlast.toList();
      try {
        return dx[0]['time_stamp'].toString();
      } catch (e) {}
    }
  }

  queryAll(String button) {
    String db;
    String value;

    print("data periodic :  " + dataPeriodic[changeDataPeriodic].toString());
    print(" timeDisplayStart " + timeDisplayStart);
    print(" timeDisplayEnd " + timeDisplayEnd);

    var hourToDays = stackHour / 24;
    if (stackHour < 24) {
      changeDataPeriodic = 0;
    } else if (hourToDays < 32) {
      changeDataPeriodic = 1;
    } else if (hourToDays < 512) {
      changeDataPeriodic = 2;
    } else if (hourToDays >= 512) {
      changeDataPeriodic = 3;
    } else {}

    if (dataPeriodic[changeDataPeriodic].toString() == "Hour") {
      print("select hour");

      if (button == "left") {
        value = minutecalculate(
            (stackHour.round()), timeDisplayStart, timeDisplayEnd);
      } else if (button == "right") {
        value = minutecalculate(
            (-stackHour.round()), timeDisplayStart, timeDisplayEnd);
      }

      db = "minutes";
    }

    if (dataPeriodic[changeDataPeriodic].toString() == "Day") {
      print("select Day");
      if (button == "left") {
        value = daycalculate(
            (hourToDays.round()), timeDisplayStart, timeDisplayEnd);
      } else if (button == "right") {
        value = daycalculate(
            (-hourToDays.round()), timeDisplayStart, timeDisplayEnd);
      }
      db = "hourly";
    }

    if (dataPeriodic[changeDataPeriodic].toString() == "Week") {
      if (button == "left") {
        value =
            daycalculate(hourToDays.round(), timeDisplayStart, timeDisplayEnd);
      } else if (button == "right") {
        value =
            daycalculate(-hourToDays.round(), timeDisplayStart, timeDisplayEnd);
      }
      db = "daily";
    }

    if (dataPeriodic[changeDataPeriodic].toString() == "Month") {
      if (button == "left") {
        value =
            daycalculate(hourToDays.round(), timeDisplayStart, timeDisplayEnd);
      } else if (button == "right") {
        value =
            daycalculate(-hourToDays.round(), timeDisplayStart, timeDisplayEnd);
      }
      db = "month";
    }

    String start = value.split(" ")[0];
    String end = value.split(" ")[1];

    print("value konversi : " + value.toString());

    print("dateHour : " + dateAndHour());

    var endDateLogic = DateTime.parse(end);
    if (endDateLogic.isAfter(DateTime.now())) {
      print("After");
      toasFlutter("Sorry, Data not Available at this time..");
    } else {
      timeDisplayStart = start;
      timeDisplayEnd = end;
      dataQuery =
          'SELECT * FROM $db WHERE time_stamp BETWEEN "$start" AND "$end"';
    }
    timestartweek = timeDisplayStart;
    timestartweek = DateFormat('dd').format(DateTime.parse(timestartweek));

    timestartweek = timeDisplayStart;
    timestartweek = DateFormat('dd').format(DateTime.parse(timestartweek));

    timeendweek = timeDisplayEnd;
    timeendweek = DateFormat('dd').format(DateTime.parse(timeendweek));

    timeweekstart = timeDisplayStart;
    timeweekstart = DateFormat('yMMM').format(DateTime.parse(timeweekstart));

    timestartday = timeDisplayStart;
    timestartday = DateFormat('dd').format(DateTime.parse(timestartday));

    timeendday = timeDisplayEnd;
    timeendday = DateFormat('dd').format(DateTime.parse(timeendday));

    timedayend = timeDisplayStart;
    timedayend = DateFormat('yMMM').format(DateTime.parse(timedayend));

    timestarthour = timeDisplayStart;
    timestarthour = DateFormat('kk').format(DateTime.parse(timestarthour));

    timeendhour = timeDisplayEnd;
    timeendhour = DateFormat('kk').format(DateTime.parse(timeendhour));

    timehour = timeDisplayStart;
    timehour = DateFormat('Hm').format(DateTime.parse(timehour));

    timehour1 = timeDisplayStart;
    timehour1 = DateFormat('yMMMMd').format(DateTime.parse(timehour1));

    setState(() {});
  }

  initdatabase() async {
    var inisialisai = await DBProvider.db;
    inisialisai.initDB("tabelData");
    print("Init DB...");
  }

  _getPartialData(String dbname) async {
    String lastDB = dbname;
    if (dbname == "5minutes") {
      lastDB = "minutes";
    }

    DateTime now = DateTime.now();
    String urlDb;
    var StartFormat;
    var differenceTime;
    var lastData = await lastDbData(lastDB);
    print(lastData);

    if (lastData != null) {
      if (lastData.toString().contains('.')) {
        StartFormat =
            DateTime.parse(lastData.toString().split(".")[0]); // data menit
      } else {
        StartFormat =
            DateTime.parse(lastData.toString().split("+")[0]); // data jam

      }

      print(StartFormat);

      var addStartFormat;
      if (dbname == "minutes") {
        urlDb = "5minutes";
        addStartFormat = StartFormat.add(new Duration(minutes: 1));
        differenceTime = now.difference(StartFormat).inMinutes;
      } else {
        urlDb = "hourly";

        differenceTime = now.difference(StartFormat).inHours;
        if (differenceTime == 1) {
          addStartFormat = StartFormat.add(new Duration(hours: 1));
        } else if (differenceTime > 1) {
          addStartFormat = StartFormat.add(new Duration(hours: differenceTime));
        }
      }

      print("start format : " + addStartFormat.toString());
      try {
        var timeStartFormat =
            new DateFormat('yyyyMMddTkkmmss').format(addStartFormat).toString();

        var timeEndFormat =
            new DateFormat('yyyyMMddTkkmmss').format(now).toString();

        print("Sekarang : " + timeEndFormat);
        print("Lastdata : " + timeStartFormat);

        print("perbedaan : " + differenceTime.toString());

        try {
          print("push");
          EmployeeApiProvider()
              .getPartialdata(timeStartFormat, timeEndFormat, urlDb);
        } catch (e) {
          print("error" + e.toString());
        }

        setState(() {
          changeQuery1("data1", "data2");
        });
      } catch (e) {
        String tgl = DateTime.now()
            .toString()
            .replaceAll("-", "")
            .replaceAll(":", "")
            .replaceAll(" ", "T");
        EmployeeApiProvider().getPartialdata(lastData.toString(), tgl, dbname);

        print(e.toString());
      }
    } else {
      _getAllDB(dbname);
    }
  }

  _getAllDB(String dbname) async {
    try {
      await EmployeeApiProvider().getPartialdata("", "", dbname);
    } catch (e) {
      print("error" + e.toString());
    }
  }

  _loadFromApi(int i) async {
    setState(() {
      isLoading = true;
    });

    var apiProvider = EmployeeApiProvider();
    await apiProvider.getAllEmployees(i);

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  _deleteData() async {
    setState(() {
      isLoading = true;
    });

    await DBProvider.db.deleteAllEmployees();

    // wait for 1 second to simulate loading of data
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLoading = false;
    });

    print('All employees deleted');
  }

  _buildEmployeeListView() {
    print("query data" + dataQuery.toString());

    var queryResult = DBProvider.db.getAllEmployees(dataQuery, 0);

    return FutureBuilder(
      future: queryResult,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Loading data ...."),
              ),
            ],
          );
        } else if (snapshot.data.length == 0) {
          return Container(
            child: Text("No Data"),
          );
        } else {
          List raw_data = new List();
          List phasaA = new List();
          List phasaB = new List();
          List phasaC = new List();

          for (int i = 0; i < snapshot.data.length; i++) {
            raw_data.add(snapshot.data[i].time_stamp.toString());
            phasaA.add(snapshot.data[i].energy_a);
            phasaB.add(snapshot.data[i].energy_b);
            phasaC.add(snapshot.data[i].energy_c);
          }

          var object = jsonDecode(phasaA.toString());
          var dx = object.reduce((curr, next) =>
              curr > next ? curr : next); //[0];//jsonDecode(phasaA).;

          if (phasaA != null) {
          } else {}

          return Container(
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Colors.black,
              ),
              itemCount: titles.length,
              itemBuilder: (BuildContext context, int index) {
                dateLimit = false;

                if (index == 0) {
                  data2 = phasaA;
                }
                if (index == 1) {
                  data2 = phasaB;
                }

                if (index == 2) {
                  data2 = phasaC;
                }

                print("latest : " + data2[data2.length - 1].toString());

                return (index == titles.length)
                    ? Container(
                        color: Colors.greenAccent,
                        child: FlatButton(
                          child: Text(
                            "Load More",
                            textScaleFactor: 1.0,
                            style: TextStyle(fontSize: 18.0),
                          ),
                          onPressed: () {},
                        ),
                      )
                    : Column(
                        children: <Widget>[
                          Center(
                            child: ListTile(
                              leading: Text(
                                "${titles[index]}",
                                textScaleFactor: 1.0,
                                style: TextStyle(fontSize: 18.0),
                              ),
                              // title: Text('grafik disini'
                              //     //"Data: ${snapshot.data[snapshot.data.length - indexx].energy_total} ${snapshot.data[snapshot.data.length - indexx].energy_a} "
                              //     ),
                              title: Container(
                                width: double.infinity,
                                height: dataTinggi.toDouble(),
                                // mainAxisSize: MainAxisSize.max,
                                // child: Column(
                                //   children: <Widget>[

                                child: Echarts(option: '''
              {
                animation:false,
                height:'$dataTinggi',
              
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
                    max:$maxData,
                    inverse:true
                   
                   
                        },

                series: [{
                    
                    data: $data2,
                    type: 'bar',
                    itemStyle: {color: '$red'},
                    showBackground: true,
                    backgroundStyle: {
                        color: '#ffffff'
                    }
                    
                }]

              }
              
              '''),

                                //  ],

                                // ),,
                                // onTap: () {}, // Text(item,textAlign: TextAlign.left,style: TextStyle(fontSize: 15.0),
                              ),
                              // subtitle: Text(titles[index]
                              //     //'Time: ${snapshot.data[snapshot.data.length - indexx].time_stamp}'
                              //     ),
                            ),
                          ),
                        ],
                      );
              },
            ),
          );
        }
      },
    );
  }

  Future<void> requestPermission() async {
    final status = await Permission.storage.request();
    print("per : " + status.toString());
  }

  _timerdetik() {
    Timer(Duration(seconds: 10), () async {
      setState(() {});
    });
  }

  _CheckLastDB() async {
    var lastMinutes = await loadlast(arrayDB[0]);
    var lastHourly = await loadlast(arrayDB[1]);
    var lastDaily = await loadlast(arrayDB[2]);

    print("================== Database Terakhir ==========================");

    print("Last data DB Minutes : " + lastMinutes.toString());
    print("Last data DB Hourly : " + lastHourly.toString());
    print("Last data DB Daily : " + lastDaily.toString());

    print("================== Database Terakhir ==========================");

    await Future.delayed(const Duration(seconds: 2));
    print("now : " + dailyDate());

    print("================== ambil daily data ==========================");

    var dataDaily = await DBProvider().getRawData("SELECT * FROM daily");

    print("data on Db : " + dataDaily.toString());

    if (lastDaily == null) {
      await _getAllDB("daily");
      print("================== ambil daily json ==========================");
      await Future.delayed(const Duration(seconds: 5));
    }

    String dateNow = dailyDate().toString();

    stateData = true;
    // changeDataPeriodic = 2;
    changeDataPeriodic = 0;
    String sevenData = datePeriodic(-7);
    qMulai = sevenData;
    qAkhir = dateNow;
    timeDisplayStart = sevenData;
    timeDisplayEnd = dateNow;
    dataQuery =
        'SELECT * FROM daily WHERE time_stamp BETWEEN "$sevenData" AND "$dateNow"';
    setState(() {});

    if (lastHourly == null) {
      _getAllDB("hourly");
      print("================== ambil hourly json ==========================");
      await Future.delayed(const Duration(seconds: 15));
    }

    if (lastMinutes == null) {
      _getAllDB("5minutes");
      print("================== ambil minutes json ==========================");
      await Future.delayed(const Duration(seconds: 15));
    }

    if (lastDaily.toString() == dailyDate()) {
      print("data daily sama");

      setState(() {
        changeQuery1("data1", "data2");
      });
    }

    print("================== ambil daily data ==========================");
  }

  _checkMinutes() {
    Timer(Duration(seconds: 10), () async {
      print("cek menit");
      var LastMinutes = await loadlast(arrayDB[0]);
    });
  }

  _SetTimer() {
    Timer(Duration(seconds: 3), () async {
      label = "Proses Update DB";
      iconStatus = Icons.update;
      colorStatus = Colors.green;
      setState(() {});

      print("menit");
      var dataq = await loadlast(arrayDB[0]);
      if (dataq == null) {
        _getAllDB("5minutes");
      } else {
        changeDataPeriodic = 0;
        //  dataPeriodic

        changeQuery1("data1", "data2");
        setState(() {});
      }
    });
  }

  _SetTimer1() {
    Timer(Duration(seconds: 10), () async {
      print("hourly");
      var dataq = await loadlast(arrayDB[1]);
      if (dataq == null) {
        _getAllDB("hourly");
      } else {}

      timer = "daily";
    });
  }

  _SetTimer2() {
    Timer(Duration(seconds: 15), () async {
      print("daily");
      var dataq = await loadlast(arrayDB[2]);
      if (dataq == null) {
        _getAllDB("daily");

        Timer(Duration(seconds: 15), () async {
          changeDataPeriodic = 2;
          changeQuery1("data1", "data2");
        });
      } else {
        setState(() {});
      }
    });
  }

  _timerRoutine() {
    Timer.periodic(Duration(seconds: 20), (timer) async {
      setState(() {});
      DateTime dateTimeNow = DateTime.now();
      String date =
          dateTimeNow.toString().split(" ")[0].toString().replaceAll("-", "");
      String newdate = date + "T000000";
      print("5 detik : " + dateTimeNow.toString().split(".")[0].toString());
      print("last db : " + DBProvider().returnDB().toString());
      label1 = DBProvider().returnDB().toString();
      label2 = "dari : " + EmployeeApiProvider().getlengthdata().toString();

      var datadaily = await loadlast(arrayDB[2]);
      var datamenit = await loadlast(arrayDB[0]);
      var datajam = await loadlast(arrayDB[1]);
      if (datamenit != null && datajam != null) {
        _timergetDB();
      }
      //}
      else {
        EmployeeApiProvider()
            .getPartialdata(datadaily.toString(), newdate, "daily");
        print("ambil daily data");
      }

      print("new date : " + newdate);
    });
  }

  _timergetDB() async {
    statusMinutes = true;
    setState(() {});
    print("===================== selisih =========================");
    DateTime dateTimeNow = DateTime.now();
    String dateApi = dateTimeNow
        .toString()
        .split(".")[0]
        .replaceAll("-", "")
        .replaceAll(":", "")
        .replaceAll(" ", "T");
    //2020-05-05 12:54:59.000
    var minuteslast = await loadlast(arrayDB[0]);
    var hourlylast = await loadlast(arrayDB[1]);
    var dailylast = await loadlast(arrayDB[2]);

    print("minutes last : " + minuteslast.toString());
    print("hourly last : " + hourlylast.toString());
    print("daily last : " + dailylast.toString());
    var formatminutes = DateTime.parse(minuteslast);
    var formathourly = DateTime.parse(hourlylast);
    var formatdaily = DateTime.parse(dailylast);
    int differenceInminutes = dateTimeNow.difference(formatminutes).inMinutes;
    int differenceInhourly = dateTimeNow.difference(formathourly).inMinutes;
    int differenceIndaily = dateTimeNow.difference(formatdaily).inDays;

    print("selisih menit : " + differenceInminutes.toString());
    print("selisih jam : " +
        (differenceInhourly / 60).toString() +
        " " +
        differenceInhourly.toString());
    print("selisih hari : " + differenceIndaily.toString());

    if (differenceInminutes > 5) {
      EmployeeApiProvider()
          .getPartialdata(minuteslast.toString(), dateApi, "5minutes");
    } else if (differenceInminutes < 2) {}
    if (differenceInhourly > 70) {
      EmployeeApiProvider()
          .getPartialdata(hourlylast.toString(), dateApi, "hourly");
    }
    if (differenceIndaily > 0) {
      EmployeeApiProvider()
          .getPartialdata(dailylast.toString(), dateApi, "daily");
    }

    print("===================== selisih =========================");
  }

  List getDaysInBetween(DateTime startDate, DateTime endDate) {
    List<DateTime> raw = [];
    List days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      // days.add(startDate.add(Duration(days: i)));
      raw.add(startDate.add(Duration(days: i)));
    }
    raw.removeAt(0);
    raw.removeLast();
    print("RAW " + raw.toString());
    int totalList = raw.length;
    int halfList = (totalList / 2).round() - 1;
    print("total list " + totalList.toString());
    print("halfList " + halfList.toString());
    if (raw.length == 0) {
    } else if (raw.length == 1) {
      days.add(DateFormat('dd').format(DateTime.parse(raw[0].toString())));
    } else if (raw.length == 2) {
      days.add(DateFormat('dd').format(DateTime.parse(raw[0].toString())));
      days.add(DateFormat('dd').format(DateTime.parse(raw[1].toString())));
    } else if (raw.length % 2 == 0) {
      days.add(DateFormat('dd').format(DateTime.parse(
          raw[((totalList / 2).round() - 1) - halfList].toString())));
      days.add(DateFormat('dd').format(DateTime.parse(
          raw[((totalList / 2).round() - 1) + halfList].toString())));
    } else {
      days.add(DateFormat('dd')
          .format(DateTime.parse(raw[(totalList / 2).round() - 1].toString())));
    }
    return days;
  }

  List getHoursInBetween(DateTime startDate, DateTime endDate) {
    print("dates : ${startDate} : ${endDate}");
    List<DateTime> raw = [];
    List days = [];
    for (int i = 0; i <= endDate.difference(startDate).inHours; i++) {
      raw.add(startDate.add(Duration(hours: i)));
    }
    raw.removeAt(0);
    raw.removeLast();
    print("RAW Hours " + raw.toString());
    int totalList = raw.length;
    int halfList = (totalList / 2).round() - 1;
    print("total list " + totalList.toString());
    print("halfList " + halfList.toString());
    if (raw.length == 0) {
    } else if (raw.length == 1) {
      days.add(DateFormat('HH').format(DateTime.parse(raw[0].toString())));
    } else if (raw.length == 2) {
      days.add(DateFormat('HH').format(DateTime.parse(raw[0].toString())));
      days.add(DateFormat('HH').format(DateTime.parse(raw[1].toString())));
    } else if (raw.length % 2 == 0) {
      days.add(DateFormat('HH').format(DateTime.parse(
          raw[((totalList / 2).round() - 1) - halfList].toString())));
      days.add(DateFormat('HH').format(DateTime.parse(
          raw[((totalList / 2).round() - 1) + halfList].toString())));
    } else {
      days.add(DateFormat('HH')
          .format(DateTime.parse(raw[(totalList / 2).round() - 1].toString())));
    }
    return days;
  }

  _datechange(String formattedString) {
    var format = DateTime.parse(formattedString);
    DateTime dateTimeNow = DateTime.now();
  }
}
