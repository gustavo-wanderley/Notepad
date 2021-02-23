import 'package:intl/intl.dart';

class Utils {
  static final List<Map<int, String>> months = [
    {1: "jan"},
    {2: "fev"},
    {3: "mar"},
    {4: "abr"},
    {5: "mai"},
    {6: "jun"},
    {7: "jul"},
    {8: "ago"},
    {9: "set"},
    {10: "out"},
    {11: "nov"},
    {12: "dez"},
  ];
  
  static String converterDate(DateTime date) {
    final DateFormat format = DateFormat("dd-mm-yyyy");
    String strDate = format.format(date);

    return strDate;
  }
}
