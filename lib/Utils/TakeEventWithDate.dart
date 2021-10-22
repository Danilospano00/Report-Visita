import 'package:report_visita_danilo/Models/Azienda.dart';
import 'package:report_visita_danilo/Models/Event.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TakeEventWithDate {


 // SharedPreferences prefs = await SharedPreferences.getInstance();
  //int sogliaMedia = int.parse(prefs.getString("prioritaMedia").toString();


  //questo metodo prende una lista di eventi e una data, li compara e ritorna una nuova lista eventi che ha la data uguale a quella
  //inserita nel metodo
  static List<Event> takeEventFromList(List<Event> listaEventi, DateTime data) {
    List<Event> list = [];
    if (listaEventi.isNotEmpty) {
      for (int i = 0; i < listaEventi.length; i++) {
        if (listaEventi[i].date!.day == data.day &&
            listaEventi[i].date!.month == data.month &&
            listaEventi[i].date!.year == data.year) {
          list.add(listaEventi[i]);
        }
      }
      return list;
    } else
      return [];
  }

  /*static void calcolaSogliaAllerta(
      String valoreSoglia, List<Azienda> listaAziende) {
    if (listaAziende.isNotEmpty) {
      for (int i = 0; i < listaAziende.length; i++) {

      }
    }
  }*/
}
