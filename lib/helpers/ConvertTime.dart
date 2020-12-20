import 'package:intl/intl.dart';

String toFormatddMMyyyyhhmmWithT(String strDate){
  try{
    final dFormat = new DateFormat('dd MMM yyyy');
    return dFormat.format(DateTime.parse(strDate)).replaceAll("T", " ");
  }on Exception{
    return "Error ${Exception("message")}";
  }
}