import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

void getAppDirectory() async {
  final myDir = new Directory('/storage/emulated/0/fahmi');


  myDir.exists().then((isThere) {
    isThere ? print('exists') : print('non-existent');
  });
}

Future<File> get localFile async {

  return File('/storage/emulated/0/sundaya/db.txt');
}

Future<File> writeData(String data) async {
  getAppDirectory();
  final file = await localFile;
  final dir = await getExternalStorageDirectory();
  print("dirr : " + dir.toString());

  String body ;
  try {
    body = await file.readAsString();
    
  } catch (e) {
  }
  

  return file.writeAsString(data);
}
