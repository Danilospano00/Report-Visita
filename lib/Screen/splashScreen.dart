import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:report_visita_danilo/Screen/ViewPage.dart';

import '../costanti.dart';

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
      dynamic configurazioniPreferences = remoteConfig.getString("configurazioni");
      configPreferences = await json.decode(configurazioniPreferences);
      config= json.encode(configPreferences[0]["jsonConfig"]);
      print("JSON CONFIGURAZIONI PREFERENCES : " + configPreferences.toString());

      final PermissionStatus permissionStatus = await _getPermission();
      if (permissionStatus == PermissionStatus.granted) {

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute<void>(builder: (context) => ViewPage()),
              (route) => false,
        );

      }else{
        print("ERROR permission");
      }

    } catch (e) {
      print("ERROR");
      print(e.toString());
    print("Configurazioni non prese");

  }
  }

  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted ) {
      final Map<Permission, PermissionStatus> permissionStatus =
      await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ??
          PermissionStatus.restricted;
    } else {
      return permission;
    }
  }



}
