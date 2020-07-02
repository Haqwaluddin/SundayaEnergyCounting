import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:zoom_get_coordinate/src/providers/employee_api_provider.dart';

Widget downloadData(String dbName) {

  return 
    Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Mendownload data : "),
          Text("...  "),
          SpinKitWave(
            color: Colors.blue,
            size: 20,
          ),
        ],
      ),
    );
}

Widget buildTimer() {
  return TimerBuilder.periodic(Duration(seconds: 2), builder: (context) {
    return Text("${DateTime.now()}");
  });
}
