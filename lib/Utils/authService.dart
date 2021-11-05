import 'dart:convert';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:report_visita_danilo/Models/Azienda.dart';
import 'package:report_visita_danilo/Models/Event.dart';
import 'package:report_visita_danilo/Screen/AziendaDettaglio.dart';
import 'package:report_visita_danilo/Screen/CalendarPage.dart';
import 'package:report_visita_danilo/Screen/ListaAziendeConEventiOggi.dart';
import 'package:report_visita_danilo/Screen/LogInScreen.dart';
import 'package:report_visita_danilo/Screen/PaginaListaAziendeConSogliaRossa.dart';
import 'package:report_visita_danilo/Utils/TakeEventWithDate.dart';
import 'package:report_visita_danilo/Utils/theme.dart';
import 'package:report_visita_danilo/i18n/AppLocalizations.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';
import 'package:url_launcher/url_launcher.dart';

import '../costanti.dart';

class AuthService {
  handleAuth(List<Azienda> listaAziende, List<Azienda> listaEventDaCiclare,
      Azienda aziendaRandom, List<Event> listaEventiDiOggi) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            int meet = 0;
            List<Event> listaEventi = mainStore!.box<Event>().getAll();
            List<Event> lista = TakeEventWithDate.takeEventFromList(listaEventi, DateTime.now());
            meet=lista.length;

            dynamic user = snapshot.data;
            return Card(
              margin: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Column(
                children: [
                  Stack(
                    children: [
                      ShapeOfView(
                        elevation: 4,
                        height: 140.h,
                        shape: DiagonalShape(
                          position: DiagonalPosition.Bottom,
                          direction: DiagonalDirection.Left,
                          angle: DiagonalAngle.deg(angle: 5),
                        ),
                        child: ColoredBox(
                          color: Colors.red,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.red[900],
                                  radius: 50,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 45,
                                    child: Icon(
                                      Icons.perm_identity_outlined,
                                      size: 48,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  padding: EdgeInsets.only(left: 20.0),
                                  child: AutoSizeText(
                                    user.email.toString(),
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.sp,
                                        //overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ListaAziendeConEventiOggi(
                                      listaEventiDiOggi:
                                      lista)));
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 20.0.h, left: 16.w, right: 16.w),
                      child: Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    AppLocalizations.of(context).translate('hai') +"$meet"+ AppLocalizations.of(context).translate('meetingOggi'),
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.sp),
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.only(top: 2, bottom: 2)),
                                  Text(
                                      AppLocalizations.of(context).translate('controllaIlPlanner'),
                                      style: TextStyle(
                                        fontSize: 18, color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Icon(
                                Icons.navigate_next_rounded,
                                size: 30.sp,
                                color: Colors.grey[700],
                              ),
                            ],
                          ),

                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10.h,
                    ),
                    child: Divider(indent: 16.w),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: AutoSizeText(
                            listaEventDaCiclare.length.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 94.272766.sp,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -1.5,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Text(
                              AppLocalizations.of(context).translate('aziende'),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  listaAziende.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AziendaDettaglio(
                                          azienda: aziendaRandom,
                                        )));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 14.h, right: 16.w, left: 16.w),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        aziendaRandom.nome!,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: 2.h, bottom: 2.h)),
                                      Text(
                                        //TODO devo capire come tradurre questa frase perchè in inglese cambia l'ordine delle parole
                                        "Sono passati ${DateTime.now().difference(aziendaRandom.events[aziendaRandom.events.length - 2].date!).inDays.abs().toString()} giorni dall'ultima visita",
                                        textAlign: TextAlign.start,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            color: Colors.grey[700]),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 20.h),
                                  child: Icon(
                                    Icons.navigate_next_rounded,
                                    size: 30.sp,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(),
                  listaAziende.isEmpty?Divider():Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        flex: 8,
                        child: Divider(),
                      ),
                      ElevatedButton(
                        child: Text(
                          AppLocalizations.of(context).translate('vediTutte'),
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PaginaListaAziendeConSogliaRossa(
                                        listaAziendaConSogliaRossa:
                                            listaAziende,
                                      )));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 48.h),
                    child: ElevatedButton.icon(
                      icon: Icon(
                        Icons.tune_outlined,
                      ),
                      label: Text(
                        "Settings",
                        style: TextStyle(
                          fontSize: 18.748113.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.25,
                        ),
                      ),
                      onPressed: () {
                        singOut();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        fixedSize: Size(163.w, 36.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Card(
                      margin: EdgeInsets.only(right: 16.w, left: 16.w),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              ShapeOfView(
                                elevation: 4,
                                height: 180,
                                shape: DiagonalShape(
                                  position: DiagonalPosition.Bottom,
                                  direction: DiagonalDirection.Left,
                                  angle: DiagonalAngle.deg(angle: 10),
                                ),
                                child: ColoredBox(
                                  color: Colors.red,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, bottom: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.red[900],
                                          radius: 50,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 45,
                                            child: Icon(
                                              Icons.perm_identity_outlined,
                                              size: 48,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginScreen()),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: Text(
                                              AppLocalizations.of(context).translate('ciaoAccedi'),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13.9.sp,
                                                fontWeight: FontWeight.w700,
                                                letterSpacing: 1.25,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                text:
                                AppLocalizations.of(context).translate('vantaggiAccount'),
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin molestie ullamcorper leo porta cursus. Curabitur convallis et dolor a faucibus. Maecenas suscipit, orci faucibus porttitor pretium, tellus libero eleifend massa, eget pharetra magna enim quis arcu. Sed tempus tincidunt viverra. Phasellus nisi ligula, malesuada ut ullamcorper eget, rutrum id tortor. Donec nisl mi, iaculis ut maximus vitae, feugiat vel nunc. Aliquam varius ullamcorper nunc, sit amet mattis leo vulputate a.",
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                    height: ScreenUtil().setHeight(50),
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 200,
                            child: AutoSizeText(
                              AppLocalizations.of(context).translate('funzionalitaComplete'),
                              maxLines: 2,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.088542.sp,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.25),
                            ),
                          ),
                          RichText(
                              text: TextSpan(
                            text:                               AppLocalizations.of(context).translate('contattaci'),

                                style: new TextStyle(
                              color: Colors.orange,
                              fontSize: ScreenUtil().setSp(13.748113),
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.25,
                            ),
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () {
                                final Uri _emailLaunchUri = Uri(
                                    scheme: 'mailto',
                                    path: emailAdress,
                                    queryParameters: {
                                      'subject': subjectEmail,
                                      'body': bodyEmail,
                                    });

                                String url = _emailLaunchUri.toString();
                                url = url.replaceAll("+", " ");

                                launch(url);
                              },
                          ))
                        ],
                      ),
                    ))
              ],
            );
          }
        });
  }

  singOut() {
    FirebaseAuth.instance.signOut();
  }

  signIn(String email, String password, context) async {
    return await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  singUp(String email, String password) {
    //ritorna le credenziali o un errore da catturare
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  resetPassword(String email) {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

// apple metodi

  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  appleLogIn() async {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    /* try {
      // Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      print(appleCredential.authorizationCode);

      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      // Sign in the user with Firebase. If the nonce we generated earlier does
      // not match the nonce in `appleCredential.identityToken`, sign in will fail.
      final authResult =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);

      final displayName =
          '${appleCredential.givenName} ${appleCredential.familyName}';
      final userEmail = '${appleCredential.email}';

      final firebaseUser = authResult.user;
      print(displayName);
      //   await firebaseUser.updateProfile(displayName: displayName);
      //  await firebaseUser.updateEmail(userEmail);

      return firebaseUser;
    } catch (exception) {
      print(exception);
    }*/
  }

  fbLogIn() async {
    /* final fb = FacebookLogin();

// Log in
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

// Check result status
    switch (res.status) {
      case FacebookLoginStatus.success:
      // Logged in

      // Send access token to server for validation and auth
        final FacebookAccessToken? accessToken = res.accessToken;
        print('Access token: ${accessToken!.token}');
        final AuthCredential authCredential=FacebookAuthProvider.credential(accessToken.token);
        final result= await FirebaseAuth.instance.signInWithCredential(authCredential);
        // Get profile data
        final profile = await fb.getUserProfile();
        print('Hello, ${profile!.name}! You ID: ${profile.userId}');

        // Get user profile image url
        final imageUrl = await fb.getProfileImageUrl(width: 100);
        print('Your profile image: $imageUrl');

        // Get email (since we request email permission)
        final email = await fb.getUserEmail();
        // But user can decline permission
        if (email != null)
          print('And your email is $email');

        break;
      case FacebookLoginStatus.cancel:
      // User cancel log in
        break;
      case FacebookLoginStatus.error:
      // Log in failed
        print('Error while log in: ${res.error}');
        break;
    }*/
  }

  googleLogIn() async {
    /* GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();

    GoogleSignInAuthentication googleSignInAuthentication =

        await googleSignInAccount!.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(

      accessToken: googleSignInAuthentication.accessToken,

      idToken: googleSignInAuthentication.idToken,

    );*/
    var googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleAccount;
    GoogleSignInAuthentication googleSignInAuthentication;

    googleAccount = await googleSignIn.signIn();

    googleSignInAuthentication = await googleAccount!.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    UserCredential authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);
  }


}
