
import 'package:flutter/material.dart';

class FilterModel with ChangeNotifier {


  bool bassa = true;
  bool media=true;
  bool alta=true;

  Map<String,bool> get map => {"bassa":this.bassa,"media":this.media,"alta":this.alta};


  Future<void> setFilter(bool bassa,bool media,bool alta) async {
    this.bassa=bassa;
    this.media=media;
    this.alta=alta;

    notifyListeners();
  }

  Future<void> UpdateFilter() async {
    notifyListeners();
  }


}
