import 'package:intl/intl.dart';

class DateUtil{
  static String dateToShow(DateTime dateTime){
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  }

  static String dateToDatabase(DateTime dateTime){
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }

  static DateTime dateFromDatabaseToDartDateTime(String strDateTime){
    return DateTime.parse(strDateTime);
  }
}