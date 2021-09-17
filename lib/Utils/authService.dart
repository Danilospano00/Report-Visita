import 'dart:convert';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:report_visita_danilo/Screen/LogInScreen.dart';
import 'package:report_visita_danilo/Screen/Preferences.dart';
import 'package:report_visita_danilo/Utils/theme.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            dynamic user = snapshot.data;
            return Card(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Stack(
                    children: [
                      ShapeOfView(
                        elevation: 4,
                        height: 160,
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
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    user.email.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 160,
                        decoration: BoxDecoration(color: Colors.transparent),
                        child: Align(
                          alignment: AlignmentDirectional.bottomEnd,
                          child: FloatingActionButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Preferences()));
                            },
                            backgroundColor: Colors.grey[700],
                            child: Icon(Icons.add),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 40,
                      horizontal: 10.0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Hai 3 meeting oggi",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2)),
                              Text(
                                "Controlla il planner",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.navigate_next_rounded,
                          size: 24,
                          color: Colors.grey[700],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.open_in_new_outlined,
                              size: 80,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Allerte attive",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Dall'ultimo sync\ndel 03/09 alle 15:30",
                                      overflow: TextOverflow.visible,
                                      style: TextStyle(fontSize: 18)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 40.0, right: 10, left: 10, bottom: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 5,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Nome azienda o contatto",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2)),
                                Text(
                                  "è passato olte un mese dall'ultimo incontro...",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey[700]),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        Expanded(
                          child: Column(
                            children: [
                              Icon(
                                Icons.navigate_next_rounded,
                                size: 24,
                                color: Colors.grey[700],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: ElevatedButton(
                          child: Text(
                            "vedi tutti",
                            style: TextStyle(fontSize: 18),
                          ),
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 110.5, vertical: 50),
                        child: ElevatedButton.icon(
                          icon: Icon(
                            Icons.tune_outlined,
                          ),
                          label: Text(
                            "Setting",
                            style: TextStyle(fontSize: 18),
                          ),
                          onPressed: () {
                            singOut();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
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
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => LoginScreen()),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 20.0),
                                          child: Text(
                                            "Ciao\nAccedi al tuo account",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13.9.sp,
                                              fontWeight: FontWeight.bold,
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
                                  "Scopri tutti i vantaggi di un account registrato\n\n",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin molestie ullamcorper leo porta cursus. Curabitur convallis et dolor a faucibus. Maecenas suscipit, orci faucibus porttitor pretium, tellus libero eleifend massa, eget pharetra magna enim quis arcu. Sed tempus tincidunt viverra. Phasellus nisi ligula, malesuada ut ullamcorper eget, rutrum id tortor. Donec nisl mi, iaculis ut maximus vitae, feugiat vel nunc. Aliquam varius ullamcorper nunc, sit amet mattis leo vulputate a.",
                                  style: TextStyle(fontWeight: FontWeight.normal),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(

                    height: ScreenUtil().setHeight(50),
                    color: Colors.black,
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 200,
                            child: AutoSizeText("Vuoi accedere a tutte le funzionalità complete?",
                            maxLines: 2,
                            style: TextStyle(color:Colors.white),),
                          ),
                          RichText(
                              text:
                              TextSpan(
                                text: 'CONTATTACI',
                                style: new TextStyle(
                                  color: Colors.orange,
                                  fontSize: ScreenUtil().setSp(18),
                                  fontWeight: FontWeight.bold
                                ),
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () {



                                  },
                              ))
                        ],
                      ),
                    )
                )
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
    /*.
    then((value) => (value){
      UserCredential res=value;
    }).catchError((e){
      showError(e.toString(), context);
    });*/
  }

  singUp(String email, String password) {
    //ritorna le credensiali o un errore da catturare
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

    try {
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
    }
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

  void showError(String mess, context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          title: Text(
            "ATTENZIONE!",
            textAlign: TextAlign.center,
          ),
          content: Text(mess),
          actions: [
            ButtonTheme(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              child: RaisedButton(
                color: rvTheme.primaryColor,
                elevation: 2,
                child: Text(
                  "OK",
                  style: TextStyle(color: rvTheme.canvasColor),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  //Navigator.pop(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
