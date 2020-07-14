import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:zoom_get_coordinate/View/charts.dart';
import 'package:zoom_get_coordinate/mainpage.dart';
import 'package:zoom_get_coordinate/src/function/logic_button.dart';
import 'package:zoom_get_coordinate/src/pages/home_page.dart';
import 'package:zoom_get_coordinate/src/providers/db_provider.dart';
import 'package:zoom_get_coordinate/src/providers/employee_api_provider.dart';

// void main() => runApp(tryScreen());
void main() => runApp(MyApp1());

class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'OpenSans'),
      initialRoute: 'home',
      routes: {
        // 'home': (BuildContext context) => HomePage(),
        'home': (BuildContext context) => HomePage(),
        //MainPage()
      },
    );
  }
}

class tryScreen extends StatefulWidget {
  @override
  _tryScreenState createState() => _tryScreenState();
}

class _tryScreenState extends State<tryScreen> {

  _initDB() async {
    var getDB = await DBProvider.db;
    print("Init DB Succes");
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initDB();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Screen Trial'),
        ),
        body: Column(
          children: <Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildButton("menit"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildButton("jam"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildButton("hari"),
                  ),
                  // RaisedButton(color: Colors.blue,child: Text("Update DB",style: TextStyle(color: Colors.white),),onPressed: (){}),
                ],
              ),
            ),

            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildButton("Baca menit"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildButton("Baca Jam"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildButton("Baca Hari"),
                  ),
                ],
              ),
            ),
            // writeText("hafiz"),
            // writeText("fahmi"),
          ],
        ),
      ),
    );
  }

  Widget writeText(String text) {
    return Text("Test data" + text.toString());
  }

  Widget buildButton(String buttonName) {
    return RaisedButton(
        color: Colors.blue,
        child: Text(
          buttonName,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          logicstate(buttonName);
          print(buttonName);
        });
  }
}
