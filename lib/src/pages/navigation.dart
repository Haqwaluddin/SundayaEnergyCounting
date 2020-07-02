import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoom_get_coordinate/src/function/dbHelp.dart';
import 'package:zoom_get_coordinate/src/providers/db_provider.dart';
import 'package:zoom_get_coordinate/src/providers/employee_api_provider.dart';

var dataPeriodic = ["Hour", "Day", "Week", "Month", "year"];
var arrayDB = ['minutes', 'hourly', 'daily', 'month', 'year'];
int changeDB = 2;
int changeTime = 1;

class buldNavigator extends StatefulWidget {
  @override
  _buldNavigatorState createState() => _buldNavigatorState();
}

class _buldNavigatorState extends State<buldNavigator> {


  @override
  Widget build(BuildContext context) {
    return Center(
      // child: navButton(true),
    );
  }
}


