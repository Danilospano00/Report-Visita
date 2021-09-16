import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:report_visita_danilo/Screen/CalendarPage.dart';
import 'package:report_visita_danilo/Screen/ViewPage.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashPage extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    startTimer(context);
    return Stack(children: [
      Image.asset(
        'assets/splashpage_background1.png',
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),
      Align(
          alignment: Alignment.center,
          child: Image.asset('assets/logo_splash.png')),
    ]);
  }

  void startTimer(context) async {

    try {
      final RemoteConfig remoteConfig = await RemoteConfig.instance;
      await remoteConfig.fetch();
      await remoteConfig.fetchAndActivate();
      String urlremote = remoteConfig.getString("url");
      print(urlremote);


      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute<void>(builder: (context) => ViewPage()),
            (route) => false,
      );
    } catch (e) {
      print("ERROR");
    }
  }
}
