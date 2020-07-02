import 'package:zoom_get_coordinate/src/providers/db_provider.dart';
import 'package:zoom_get_coordinate/src/providers/employee_api_provider.dart';

import 'getDateTime.dart';

class StartupClass {
  Future<bool> StartgetdateNow(String dbName) async {
    var getLastDbData = await DBProvider.db.checkLastDB(dbName);
    if (dailyDate() == getLastDbData.toString()) {
      var countDb = await DBProvider.db.getRawData("SELECT COUNT(*) FROM daily");
      print("Panjang DB : " + countDb[0]['COUNT(*)'].toString());
      return true;
      //deteksi jika last data di database ==  date time sekarang

    } else {
      EmployeeApiProvider().getPartialdata("", "", dbName);
      
      
      return false;
    }
  }


}
