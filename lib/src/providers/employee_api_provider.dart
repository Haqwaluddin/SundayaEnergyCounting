import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:zoom_get_coordinate/src/function/storage.dart';
import 'package:zoom_get_coordinate/src/models/employee_model.dart';
import 'package:zoom_get_coordinate/src/providers/db_provider.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;


int lentgData = 0;

var path = ["5minutes", "hourly"];

class EmployeeApiProvider {
  int getlengthdata() {
    return lentgData;
  }

  Future<List<Employee>> getAllEmployees(int i) async {
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(
        now.year, now.month, now.day, now.hour, now.minute, now.second);

    var endDate = new DateFormat('yyyyMMddTkkmmss').format(date).toString();
    var startDateget = date.add(new Duration(hours: -10));

    var startDate =
        new DateFormat('yyyyMMddTkkmmss').format(startDateget).toString();

    startDate = startDate.replaceAll("24", "00");

    var url = "http://119.18.158.238:8001/api/chint/" +
        path[1].toString() +
        "?date_start=" +
        startDate +
        "&date_end=" +
        endDate;

    //ambil semua data
    url = "http://119.18.158.238:8001/api/chint/" + path[i].toString();
    //ambil semua data

    var token = '87zPVKPw.h3Up7yBVHenVx184JvHOf5qpOYM7yhyf';

    var tokenAll = 'Token 8226b600713a37abf2e018995e2a4add8ddf03e9';

    var responseData = await http.get(
      url,
      headers: {"Authorization": "$tokenAll"},
    );

    print("URl : " + url.toString());

    var data = json.decode(responseData.body);

    var panjangData = data[0]['data'][0];
    print("Data Masuk : " + panjangData.toString());

    return (data[0]['data'] as List).map((employee) {

      if (i == 0) {
        DBProvider.db.createEmployee(Employee.fromJson(employee), "minutes");
      } else if (i == 1) {
        print("disini");
        DBProvider.db.createEmployee(Employee.fromJson(employee), "hourly");
      }
    }).toList();
  }

  Future getPartialdata(String startTime, String endTime, String dbName) async {
    String insertInto = "";
    if (dbName == "5minutes") {
      insertInto = "minutes";
    } else if (dbName == "hourly") {
      insertInto = "hourly";
    } else if (dbName == "daily") {
      insertInto = "daily";
    }
    var tokenAll = 'Token 8226b600713a37abf2e018995e2a4add8ddf03e9';
    String apiUrl;
    if (startTime == "" && endTime == "") {
      apiUrl = "http://119.18.158.238:8001/api/chint/" + dbName;
    } else {
      apiUrl = "http://119.18.158.238:8001/api/chint/" +
          dbName +
          "?date_start=" +
          startTime +
          "&date_end=" +
          endTime;
    }

    print(apiUrl);

    var apiResult = await http.get(apiUrl, headers: {
      "Authorization": "$tokenAll",
    });

    var jsonObject = json.decode(apiResult.body);
    if (dbName == "daily") {
      List listA = jsonObject[0]['data'] as List;
      lentgData = listA.length;
      print("Panjang : " + lentgData.toString());
      getlengthdata();
    }

    (jsonObject[0]['data'] as List).map((employee) {
      DBProvider.db.createEmployee(Employee.fromJson(employee), insertInto);
    }).toList();

    print(jsonObject[0]['data']);
    print("Akhir data.....");
  }

  static Future<EmployeeApiProvider> connectToAPI() async {
    var tokenAll = 'Token 8226b600713a37abf2e018995e2a4add8ddf03e9';
    String apiUrl =
        "http://192.168.2.8:8001/api/chint/5minutes?date_start=20200504T0857&date_end=20200504T092000";
    var apiResult =
        await http.get(apiUrl, headers: {"Authorization": "$tokenAll"});
    var jsonObject = json.decode(apiResult.body);
    var userData = (jsonObject as Map<String, dynamic>)['current'];

    print(jsonObject);
    return EmployeeApiProvider.createweather(userData);
  }

  String time;
  String temperature;
  String main;

  EmployeeApiProvider({this.time, this.temperature, this.main});
  factory EmployeeApiProvider.createweather(Map<String, dynamic> object) {
    return EmployeeApiProvider(
      time: object['dt'],
      temperature: object['temp'],
    );
  }
}
