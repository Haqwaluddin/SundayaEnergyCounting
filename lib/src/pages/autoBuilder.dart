import 'package:flutter/cupertino.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:zoom_get_coordinate/src/function/getDateTime.dart';
import 'package:zoom_get_coordinate/src/function/startup.dart';
import 'package:zoom_get_coordinate/src/providers/db_provider.dart';

void get() async{
  var dataLastDaily = await  StartupClass().StartgetdateNow("daily");

  print(dataLastDaily);

}

Widget buildTimer (){
  return TimerBuilder.periodic(Duration(seconds: 10),
      builder: (context) {

        get();

        return Text("${DateTime.now()}");
      }
    ); 
}