import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:zoom_get_coordinate/src/providers/db_provider.dart';

Widget BuildBar() {
  return FutureBuilder(
      future: DBProvider.db.getAllData("daily"),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        print(snapshot.data[0].time_stamp.toString());
      });
}

List totalEnergy(List rawdata) {

  List totalData;

  if (rawdata != null) {
    for (var i = 0; i < rawdata.length; i++) {
      try {
        totalData.add(rawdata[i]['energy_total'].toString());
      } catch (e) {}
    }

    print(totalData);

    return totalData;
  } else {
    print("object");
    return [];
  }


}

Future<List> tot () async{
  List totalData = List();
  await DBProvider.db.getAllData("daily").then((onValue){

    for (var i = 0; i < onValue.length; i++) {
      totalData.add(onValue[i]['energy_total']);
      
    }

    print(totalData);
    
    return totalData;

  });
}
