import 'package:intl/intl.dart';

String dailyDate() {
  var today = new DateTime.now();

  var format = DateFormat('yyyyMMddT000000').format(today).toString();
  return format.toString();
}

String datePeriodic(int dailyPeriodic) {
  var today = new DateTime.now();
  var peridicdaily = today.add(new Duration(days: dailyPeriodic));
  var format = DateFormat('yyyyMMddT000000').format(peridicdaily).toString();
  return format;
}

String dateAndHour() {
  var today = new DateTime.now();
  var format = DateFormat('yyyyMMddTHH0000').format(today).toString();

  return format.toString();
}

String minutecalculate(int dateCalculate, String start, String end) {

  String waktuEnd = DateFormat('yyyyMMddTHH0000').format(DateTime.parse(end));
  String waktuStart = DateFormat('yyyyMMddTHH0000').format(DateTime.parse(start));

  var dataStart = DateTime.parse(waktuStart);
  var dataEnd = DateTime.parse(waktuEnd);

  print("waktu e : " + waktuEnd);
  print("waktu s : " + waktuStart);
  print("kalkulate : " + dateCalculate.toString());

  var StartPeriodically = dataStart.add(new Duration(hours: -dateCalculate));
  var EndPeriodically = dataEnd.add(new Duration(hours: -dateCalculate));

  return StartPeriodically.toString()
          .split(".")[0]
          .replaceAll(" ", "T")
          .replaceAll("-", "")
          .replaceAll(":", "")
          .toString() +
      " " +
      EndPeriodically.toString()
          .split(".")[0]
          .replaceAll(" ", "T")
          .replaceAll("-", "")
          .replaceAll(":", "")
          .toString();
}

String daycalculate(int dateCalculate, String start, String end) {
  var dataStart = DateTime.parse(start);
  var dataEnd = DateTime.parse(end);

  // dataEnd = DateTime

  print("kalkulate : " + dateCalculate.toString());

  var StartPeriodically = dataStart.add(new Duration(days: -dateCalculate));
  var EndPeriodically = dataEnd.add(new Duration(days: -dateCalculate));


  return StartPeriodically.toString()
          .split(".")[0]
          .replaceAll(" ", "T")
          .replaceAll("-", "")
          .replaceAll(":", "")
          .toString() +
      " " +
      EndPeriodically.toString()
          .split(".")[0]
          .replaceAll(" ", "T")
          .replaceAll("-", "")
          .replaceAll(":", "")
          .toString();
}



String datecalculate(int dateCalculate, String start, String end) {
  var dataStart = DateTime.parse(start);
  var dataEnd = DateTime.parse(end);

  var StartPeriodically = dataStart.add(new Duration(days: -dateCalculate));
  var EndPeriodically = dataEnd.add(new Duration(days: -dateCalculate));

  return StartPeriodically.toString()
          .split(".")[0]
          .replaceAll(" ", "T")
          .replaceAll("-", "")
          .replaceAll(":", "")
          .toString() +
      " " +
      EndPeriodically.toString()
          .split(".")[0]
          .replaceAll(" ", "T")
          .replaceAll("-", "")
          .replaceAll(":", "")
          .toString();
}
