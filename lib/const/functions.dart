
import 'package:intl/intl.dart';

class Functions{
  static final DateFormat format = DateFormat.yMd().add_jm();
  static String convertDate(String sDate){
    DateTime dateTime = DateTime.parse(sDate);
    return format.format(dateTime);
  }
}