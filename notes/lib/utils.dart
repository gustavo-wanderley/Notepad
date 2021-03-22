import 'package:intl/intl.dart';

class Utils {
  

  static String converterDate(DateTime date) {
    final DateFormat format = DateFormat("dd/MM/yyyy"); 
    String strDate = format.format(date);
    return strDate;
  }

  static String resumeSummary(String text){
    return "${text.substring(0, 83)} ...";
  }
}
