import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:report_visita_danilo/Models/User.dart';
import 'package:report_visita_danilo/Utils/authService.dart';
import 'package:report_visita_danilo/Utils/horizontaldivider.dart';
import 'package:report_visita_danilo/Utils/theme.dart';
import 'package:report_visita_danilo/i18n/AppLocalizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:sign_in_apple/sign_in_apple.dart';
import 'package:sign_in_apple/apple_id_user.dart';

import 'Preferences.dart';
import 'Registration.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  bool _isLoading = false;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          shadowColor: Colors.grey,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
          ),
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey,
        body: Padding(
          padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(16),
              right: ScreenUtil().setWidth(16),
              bottom: ScreenUtil().setHeight(60)),
          child: Container(
            padding: EdgeInsets.only(
                top: ScreenUtil().setWidth(16),
                left: ScreenUtil().setWidth(16),
                right: ScreenUtil().setWidth(16)),
            //height: ScreenUtil().screenHeight,
            color: rvTheme.canvasColor,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(ScreenUtil().setHeight(8)),
                  child: AutoSizeText(
                    AppLocalizations.of(context).translate('effettuaIlLogin'),
                    maxLines: 1,
                    style: TextStyle(fontSize: ScreenUtil().setSp(24)),
                  ),
                ),
                FormBuilder(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: Column(children: <Widget>[
                      FormBuilderTextField(
                        name: 'email',
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context).translate('emailNonValida'),
                          prefixIcon:
                              Icon(Icons.account_box, color: rvTheme.hintColor),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                          FormBuilderValidators.email(context),
                        ]),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: ScreenUtil().setSp(8),
                      ),
                      FormBuilderTextField(
                        name: 'password',
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context).translate('passwordNonValida'),
                          prefixIcon: Icon(
                            Icons.vpn_key_outlined,
                            color: rvTheme.hintColor,
                          ),
                        ),
                        obscureText: true,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                          FormBuilderValidators.minLength(context, 6),
                        ]),
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(16),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () {},
                          child: AutoSizeText(
                            AppLocalizations.of(context).translate('passwordDimenticata'),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(14),
                                fontWeight: FontWeight.w100),
                            maxLines: 2,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top:8.h),
                        child: MaterialButton(
                          color: rvTheme.primaryColorDark,
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ??
                                false) {
                              // _setFirstAccess();
                              setState(() {
                                _isLoading = true;

                                animateButton();
                              });
                              print('Valid');
                            } else {
                              print('Invalid');
                            }
                          },
                          child: setUpButtonChild( AppLocalizations.of(context).translate('accedi'),),
                          elevation: 4.0,
                          minWidth: double.infinity,
                          height: 48.0.h,
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setSp(16),
                      ),
                      HorizontalOrLine(
                          color: rvTheme.unselectedWidgetColor,
                          height: ScreenUtil().setHeight(1),
                          label: AppLocalizations.of(context).translate('oppure')),
                      SizedBox(
                        height: ScreenUtil().setHeight(16),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircleAvatar(
                              radius: 24,
                              backgroundColor: Colors.blue,
                              child: IconButton(
                                  onPressed: () {
                                    dynamic res = AuthService().googleLogIn();
                                    if (res != null){
                                      print(res.toString());
                                      Navigator.pop(context);}
                                  },
                                  icon: Image.asset(
                                    "assets/icons8-google-24.png",
                                    color: Colors.white,
                                  ))),
                          if(Platform.isIOS)
                          CircleAvatar(
                              radius: 24,
                              backgroundColor: Colors.black,
                              child: IconButton(
                                  onPressed: ()  {
                                    //SignInApple.clickAppleSignIn();
                                    dynamic res =  AuthService().appleLogIn();
                                    if (res != null){
                                      print(res.toString());
                                      Navigator.pop(context);}
                                   },
                                  icon: Image.asset(
                                    "assets/icons8-apple-logo-24.png",
                                    color: Colors.white,
                                  ))),
                          CircleAvatar(
                              radius: 24,
                              backgroundColor: Colors.blue,
                              child: IconButton(
                                  onPressed: () {
                                    lnkLogIn();
                                  },
                                  icon: Image.asset(
                                    "assets/icons8-linkedin-24.png",
                                    color: Colors.white,
                                  ))),
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(12),
                      ),
                      Divider(
                        color: rvTheme.unselectedWidgetColor,
                        height: ScreenUtil().setHeight(1),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(12),
                      ),
                      Padding(
                        padding: EdgeInsets.all(ScreenUtil().setHeight(8)),
                        child: AutoSizeText(
                          AppLocalizations.of(context).translate("nonHaiUnAccount"),
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(24),
                              letterSpacing: 0.9,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(12),
                      ),
                      MaterialButton(
                        color: rvTheme.primaryColorDark,
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegistrationScreen()),
                          );
                        },
                        child: setUpButtonChild( AppLocalizations.of(context).translate('registrati'),),
                        elevation: 4.0,
                        minWidth: double.infinity,
                        height: 48.0.h,
                      ),
                    ])),
              ],
            ),
          ),
        ));
  }

  Widget setUpButtonChild(String _text) {
    if (!_isLoading) {
      return new Text(
        _text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
        ),
      );
    } else {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    }
  }






  Future<void> animateButton() async {
    User user = User.init(_formKey.currentState!.fields);

    dynamic res = await AuthService().signIn(
        user.email!.replaceAll(new RegExp(r"\s+"), ""),
        user.password!,
        context);
    if (res != null) {
      final SharedPreferences prefs = await _prefs;
      if (!(prefs.containsKey("isFirstAccess") ||
          prefs.getBool("isFirstAccess") == false)) {
        prefs.setBool("isFirstAccess", true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Preferences()),
        );
      } else {
        Navigator.pop(context);
      }
    } else {
      //errore log in
    }

    setState(() {
      _isLoading = false;
    });
  }

  lnkLogIn()async{

    String redirectUrl = "https://url.com";
    String clientId = ""; /// Your linkedin client id
    String clientSecret = "";

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) =>
            LinkedInUserWidget(
              redirectUrl: redirectUrl,
              clientId: clientId,
              clientSecret: clientSecret,
              onGetUserProfile: (UserSucceededAction linkedInUser) async{
                /// This api call retrives profile picture
              /*  Response response = await dio.get(
                    "https://api.linkedin.com/v2/me?projection=(profilePicture(displayImage~:playableStreams))",
                    options: Options(
                        responseType: ResponseType.json,
                        sendTimeout: 60000,
                        receiveTimeout: 60000,
                        headers: {
                          HttpHeaders.authorizationHeader: "Bearer ${linkedInUser.token.accessToken}"
                        }
                    )
                );
                var profilePic = response.data["profilePicture"]["displayImage~"]["elements"][0]["identifiers"][0]["identifier"];
*/
                Map<String, dynamic> postJson = {
                  "user_id": linkedInUser.user.userId,
                  "email": linkedInUser.user.email!.elements![0].handleDeep!.emailAddress,
                  //"pic_url": profilePic,
                  "name": linkedInUser.user.firstName!.localized!.label! + ' ' + linkedInUser.user.lastName!.localized!.label!,
                  "token": linkedInUser.user.token.accessToken,
                  "expires_in": linkedInUser.user.token.expiresIn
                };
                setState(() {
                 // result = postJson;
                });
                Navigator.of(context).pop();
              },
              onError: (UserFailedAction e) {
                print('Error: ${e.toString()}');
                print('Error: ${e.stackTrace.toString()}');
              },
            ),
        fullscreenDialog: false,
      ),
    );



  }




}
