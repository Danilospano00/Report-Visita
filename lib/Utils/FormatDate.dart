import 'package:flutter/material.dart';

class FormatDate {

  static const String DATA = "data";

  static const String ORARIO = "orario";

  static String fromDateTimeToString(DateTime data, String stringa) {
    /*String convertedDateTime = "${data.year.toString()}-${data.month.toString()
        .padLeft(2, '0')}-${data.day.toString().padLeft(2, '0')} ${data.hour
        .toString().padLeft(2, '0')}-${data.minute.toString().padLeft(2, '0')}";
*/
    if (stringa == DATA) {
      String convertedDateTime = "${data.day.toString()}"+" "+_monthFromNumberToString(data)+" "+"${data.year.toString()}";
      return convertedDateTime;
    }
    else if(stringa == ORARIO){
      String convertedDateTime = "${data.hour
          .toString()}:${data.minute.toString()}";
      return convertedDateTime;
    }
      else return "Errore";
  }

  static String _monthFromNumberToString(DateTime data){
    String meseInNumeri = "${data.month.toString()}";
    switch(meseInNumeri){
      case "1": return "Gennaio";
      case "2": return "Febbraio";
      case "3": return "Marzo";
      case "4": return "Aprile";
      case "5": return "Maggio";
      case "6": return "Giugno";
      case "7": return "Luglio";
      case "8": return "Agosto";
      case "9": return "Settembre";
      case "10": return "Ottobre";
      case "11": return "Novembre";
      case "12": return "Dicembre";
      default: return "Error";
    }
  }

}