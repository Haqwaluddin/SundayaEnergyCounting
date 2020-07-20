import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';

dateToStr(date) {
  String format = DateFormat("yyyy-MM-dd HH:mm").format(DateTime.parse(date));
  return format;
}

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
  String waktuStart =
      DateFormat('yyyyMMddTHH0000').format(DateTime.parse(start));

  var dataStart = DateTime.parse(waktuStart);
  var dataEnd = DateTime.parse(waktuEnd);

  print("waktu e : " + waktuEnd);
  print("waktu s : " + waktuStart);
  print("kalkulate : " + dateCalculate.toString());

  var startPeriodically = dataStart.add(new Duration(hours: -dateCalculate));
  var endPeriodically = dataEnd.add(new Duration(hours: -dateCalculate));

  return startPeriodically.toString()
          .split(".")[0]
          .replaceAll(" ", "T")
          .replaceAll("-", "")
          .replaceAll(":", "")
          .toString() +
      " " +
      endPeriodically.toString()
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

  var startPeriodically = dataStart.add(new Duration(days: -dateCalculate));
  var endPeriodically = dataEnd.add(new Duration(days: -dateCalculate));

  return startPeriodically.toString()
          .split(".")[0]
          .replaceAll(" ", "T")
          .replaceAll("-", "")
          .replaceAll(":", "")
          .toString() +
      " " +
      endPeriodically.toString()
          .split(".")[0]
          .replaceAll(" ", "T")
          .replaceAll("-", "")
          .replaceAll(":", "")
          .toString();
}

String datecalculate(int dateCalculate, String start, String end) {
  var dataStart = DateTime.parse(start);
  var dataEnd = DateTime.parse(end);

  var startPeriodically = dataStart.add(new Duration(days: -dateCalculate));
  var endPeriodically = dataEnd.add(new Duration(days: -dateCalculate));

  return startPeriodically.toString()
          .split(".")[0]
          .replaceAll(" ", "T")
          .replaceAll("-", "")
          .replaceAll(":", "")
          .toString() +
      " " +
      endPeriodically.toString()
          .split(".")[0]
          .replaceAll(" ", "T")
          .replaceAll("-", "")
          .replaceAll(":", "")
          .toString();
}

String monthcalculate(int dateCalculate, String start, String end) {
  var dataStart = DateTime.parse(start);
  var dataEnd = DateTime.parse(end);

  print("START : " + dataStart.toString());
  print("END : " + dataEnd.toString());

  var startPeriodically = DateTime(dataStart.year, dataStart.month -dateCalculate, dataStart.day);
  var endPeriodically = DateTime(dataEnd.year, dataEnd.month -dateCalculate, dataEnd.day);

  print("START PER : " + startPeriodically.toString());
  print("END PER : " + endPeriodically.toString());

  // return startPeriodically.toString()
  //         .split(".")[0]
  //         .replaceAll(" ", "T")
  //         .replaceAll("-", "")
  //         .replaceAll(":", "")
  //         .toString() +
  //     " " +
  //     endPeriodically.toString()
  //         .split(".")[0]
  //         .replaceAll(" ", "T")
  //         .replaceAll("-", "")
  //         .replaceAll(":", "")
  //         .toString();
}
