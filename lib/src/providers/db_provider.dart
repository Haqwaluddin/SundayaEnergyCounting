import 'dart:io';
import 'package:zoom_get_coordinate/src/function/storage.dart';
import 'package:zoom_get_coordinate/src/function/toastInformation.dart';
import 'package:zoom_get_coordinate/src/models/employee_model.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zoom_get_coordinate/src/pages/home_page.dart';
import 'package:zoom_get_coordinate/src/providers/employee_api_provider.dart';

String storeDB = "DBno action ";
String dbName = "";

class DBProvider {
  String ok;

  static Database _database, database1;
  static final DBProvider db = DBProvider._();

  DBProvider({this.ok});

  DBProvider._();

  String returnDB() {
    return storeDB;
  }

  String getDBName(){

    return dbName;

  }

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB("Employee");
    // database1 = await initDB("hourly");

    return _database;
  }

  Future<Database> get databaseHour async {
    // If database exists, return database
    if (database1 != null) return database1;

    // If database don't exists, create one
    database1 = await initDB("hourly");
    // print("init namaDB : hourly");

    return database1;
  }

  // Create the database and the Employee table
  // initDB() async {
  //   Directory documentsDirectory = await getApplicationDocumentsDirectory();
  //   final path = join(documentsDirectory.path, 'employee_manager.db');

  //   return await openDatabase(path, version: 1, onOpen: (db) {},
  //       onCreate: (Database db, int version) async {
  //     await db.execute('CREATE TABLE Employee('
  //         'id INTEGER PRIMARY KEY,'
  //         'email TEXT,'
  //         'firstName TEXT,'
  //         'lastName TEXT,'
  //         'avatar TEXT'
  //         ')');
  //   });
  // }

  // init dg to get data from github

  initDB(String tabelData) async {
    // print("nama db new : " + tabelData);
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'sundaya_manager.db');
    var dbx = await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE minutes('
          'time_stamp TEXT PRIMARY KEY,'
          'energy_total TEXT,'
          'energy_a TEXT,'
          'energy_b TEXT,'
          'energy_c TEXT'
          ')');
      print("create minutes DB");
      await db.execute('CREATE TABLE hourly('
          'time_stamp TEXT PRIMARY KEY,'
          'energy_total TEXT,'
          'energy_a TEXT,'
          'energy_b TEXT,'
          'energy_c TEXT'
          ')');
      print("create hourly DB");
      await db.execute('CREATE TABLE daily('
          'time_stamp TEXT PRIMARY KEY,'
          'energy_total TEXT,'
          'energy_a TEXT,'
          'energy_b TEXT,'
          'energy_c TEXT'
          ')');
      await db.execute('CREATE TABLE month('
          'time_stamp TEXT PRIMARY KEY,'
          'energy_total TEXT,'
          'energy_a TEXT,'
          'energy_b TEXT,'
          'energy_c TEXT'
          ')');


      print("create daily DB");

      String report = "try Create DB";
      String report1 =
          "Create DB : employee_manager.db Table :  minutes, hourly, daily";

    }


        );

    return dbx;
  }

 

  // Insert employee on database
  createEmployee(Employee newEmployee, String dbName) async {
    var db = await databaseHour;
    var res; //= await db.insert('hourly', newEmployee.toJson());
    if (dbName == "minutes") {

      res = await db.insert('minutes', newEmployee.toJson(),
          conflictAlgorithm: ConflictAlgorithm.ignore);
    } else if (dbName == "hourly") {

      res = await db.insert('hourly', newEmployee.toJson(),
          conflictAlgorithm: ConflictAlgorithm.ignore);
    } else if (dbName == "daily") {

      res = await db.insert('daily', newEmployee.toJson(),
          conflictAlgorithm: ConflictAlgorithm.ignore);
    } else if (dbName == "month") {

      res = await db.insert('month', newEmployee.toJson(),
          conflictAlgorithm: ConflictAlgorithm.ignore);
    }
    storeDB = "Action di Database : " + res.toString();
    dbName = dbName;
    returnDB();
    getDBName();
    DateTime now = DateTime.now();
    print(dbName + "   :   " + now.second.toString());

    return res;

  }

  // Delete all employees
  Future<int> deleteAllEmployees() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM minutes');
    final res1 = await db.rawDelete('DELETE FROM daily');
    final res2 = await db.rawDelete('DELETE FROM hourly');


    print("delete all");

    return res;
  }

  Future<List<Employee>> getAllEmployees(String query, int selectDB) async {
    var db = await database;
    try {
      if (changeDataPeriodic == 0) {
        print("database menit");
        db = await database;
      } else if (changeDataPeriodic == 1) {
        db = await databaseHour;
        print("database jam");
      }

      final res =
          await db.rawQuery(query); //'SELECT * FROM EMPLOYEE'); //bettween
      List<Employee> list =
          res.isNotEmpty ? res.map((c) => Employee.fromJson(c)).toList() : [];
      
      if (res.isEmpty) {
        toasFlutter("Data not Available at this time.." + res.toString());
        
      }

      return list;
    } catch (e) {
      print("Query error : " + e.toString());
      return [];
    }

  }

  Future<List> getLastData(String query) async {
    try {
      final db = await database;
      final res =
          await db.rawQuery(query); //'SELECT * FROM EMPLOYEE'); //bettween
      List<Employee> list =
          res.isNotEmpty ? res.map((c) => Employee.fromJson(c)).toList() : [];

      return res;
    } catch (e) {
      print("belum ada db");
      toasFlutter("Data not Available at this time..");
      return [];
    }
  }

    Future<String> checkLastDB(String dbname) async {
    try {
      final db = await database;
      final res =
          await db.rawQuery("SELECT * FROM $dbname ORDER BY time_stamp DESC LIMIT 1"); //'SELECT * FROM EMPLOYEE'); //bettween
      List<Employee> list =
          res.isNotEmpty ? res.map((c) => Employee.fromJson(c)).toList() : [];

      var dxTime;

      if (res !=null) {

        dxTime = res.toList();
        return dxTime[0]['time_stamp'].toString();
        
      }
      else{
        return "";
      }

    } catch (e) {
      print("belum ada db");
      toasFlutter("Data not Available at this time..");
      return "";
    }
  }

  Future<List> getRawData(String query) async {
    try {
      final db = await database;

      final res = await db.rawQuery(query);
      List<Employee> list =
          res.isNotEmpty ? res.map((c) => Employee.fromJson(c)).toList() : [];

      return res;
    } catch (e) {
      print("belum ada db");
      return [];
    }
  }

    Future<List> getAllData(String dbName) async {
    try {
      final db = await database;

      final res = await db.rawQuery("SELECT * FROM $dbName");
      List<Employee> list =
          res.isNotEmpty ? res.map((c) => Employee.fromJson(c)).toList() : [];

      return res;
    } catch (e) {
      print("belum ada db");
      return [];
    }
  }
}
