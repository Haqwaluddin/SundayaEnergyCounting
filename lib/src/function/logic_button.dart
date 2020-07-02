import 'dart:convert';

import 'package:zoom_get_coordinate/src/models/chint_model.dart';
import 'package:zoom_get_coordinate/src/providers/db_provider.dart';
import 'package:zoom_get_coordinate/src/providers/employee_api_provider.dart';

void logicstate(String logicname) {
  String dbName = "";
  if (logicname == "menit") {
    dbName = "5minutes";
  } else if (logicname == "jam") {
    dbName = "hourly";
  } else if (logicname == "hari") {
    dbName = "daily";
  }
  else if (logicname == "Baca menit") {
    bacaDB();
  }
  if(dbName!=""){
     getJson(dbName);

  }
 
}

void getJson(String dbName) async {
  String startTime = "20200504T130000";
  String endTime = "20200504T140000";

  var getJsondata =
      EmployeeApiProvider().getPartialdata(startTime, endTime, dbName);

}

void bacaDB ()async{
  String query = 'SELECT * FROM minutes WHERE time_stamp BETWEEN "20200504T150000" AND "20200504T152000"';
    var getDB = await DBProvider.db.getRawData(query);
    var dataDB = getDB.toList();
    
    print("Bacaan DB");

}


