import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:report_visita_danilo/Models/User.dart';
import 'package:report_visita_danilo/Utils/authService.dart';
import 'package:report_visita_danilo/Utils/theme.dart';
import 'package:report_visita_danilo/i18n/AppLocalizations.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordRepeatController = TextEditingController();
  bool acceptPrivacy = false;

  bool isLoading = false;

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
              top: ScreenUtil().setHeight(40),
              left: ScreenUtil().setWidth(16),
              right: ScreenUtil().setWidth(16),
              bottom: ScreenUtil().setHeight(60)),
          child: Container(
            color: rvTheme.canvasColor,
            child: FormBuilder(
                key: _formKey,
                child: SingleChildScrollView(
                    child: Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(ScreenUtil().setWidth(8)),
                    child: AutoSizeText(
                      AppLocalizations.of(context).translate('registrati'),                      maxLines: 1,
                      style: TextStyle(fontSize: ScreenUtil().setSp(24)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                    child: FormBuilderTextField(
                      name: "email",
                      controller: emailController,

                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).translate('indirizzoEmail'),
                        prefixIcon:
                            Icon(Icons.account_box, color: rvTheme.hintColor),
                      ),
                      onChanged: (val) {
                        setState(() {});
                      },
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context).translate('indirizzoEmail');
                        } else if (!value.contains('@')) {
                          return AppLocalizations.of(context).translate("inserisciEmailValida");
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                    child: FormBuilderTextField(
                      name: "password",
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(
                            Icons.vpn_key_outlined,
                            color: rvTheme.hintColor,
                          )),
                      onChanged: (val) {
                        setState(() {});
                      },
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context).translate("inserisciPassword");
                        } else if (value.length < 6) {
                          return AppLocalizations.of(context).translate("passwordTroppoCorta");
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                    child: FormBuilderTextField(
                      name: "passwordRepeteat",
                      obscureText: true,
                      controller: passwordRepeatController,
                      decoration: InputDecoration(
                          labelText: AppLocalizations.of(context).translate("confermaPassword"),
                          prefixIcon: Icon(
                            Icons.vpn_key_outlined,
                            color: rvTheme.hintColor,
                          )),
                      onChanged: (val) {
                        setState(() {});
                      },
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context).translate("inserisciPassword");
                        } else if (value.length < 6) {
                          return AppLocalizations.of(context).translate("passwordTroppoCorta");
                        } else if (value != passwordController.text) {
                          return AppLocalizations.of(context).translate("passwordNonUguale");
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                    child: Row(
                      children: [
                        Checkbox(
                          value: acceptPrivacy,
                          activeColor: rvTheme.primaryColor,
                          onChanged: (value) {
                            setState(() {
                              acceptPrivacy = value as bool;
                            });
                          },
                        ),
                        Flexible(
                          child: Container(
                              child: RichText(
                                  text: new TextSpan(
                            text: AppLocalizations.of(context).translate("hoPresoVisione"),
                            style: new TextStyle(
                              color: Colors.black,
                              fontSize: ScreenUtil().setSp(12),
                            ),
                            children: [
                              new TextSpan(
                                text: AppLocalizations.of(context).translate("terminiECondizioni"),
                                style: new TextStyle(
                                    color: Colors.black,
                                    fontSize: ScreenUtil().setSp(12),
                                    decoration: TextDecoration.underline),
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () {},
                              ),
                              new TextSpan(
                                text: AppLocalizations.of(context).translate("e"),
                                style: new TextStyle(
                                  color: Colors.black,
                                  fontSize: ScreenUtil().setSp(12),
                                ),
                              ),
                              new TextSpan(
                                text: 'Privacy Policy',
                                style: new TextStyle(
                                    color: Colors.black,
                                    fontSize: ScreenUtil().setSp(12),
                                    decoration: TextDecoration.underline),
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () {},
                              ),
                            ],
                          ))),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                    child: MaterialButton(
                      minWidth: ScreenUtil().setWidth(200),
                      color: rvTheme.primaryColorDark,
                      disabledColor: Colors.grey,
                      onPressed: buttonDisabled()
                          ? null
                          : () {
                              if (_formKey.currentState!.saveAndValidate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                User user =
                                    User.init(_formKey.currentState!.fields);

                                AuthService()
                                    .singUp(
                                        user.email!
                                            .replaceAll(new RegExp(r"\s+"), ""),
                                        user.password!)
                                    .then((userCredes) {
                                }).catchError((e) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  showError(e.toString());
                                });
                              }
                              showPopUpRegistrazioneAvvenuta();
                            },
                      child: Text(
                          AppLocalizations.of(context).translate("registrati"),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(ScreenUtil().setWidth(24)))
                ]))),
          ),
        ));
  }

  bool buttonDisabled() {
    if (_formKey.currentState == null) return true;
    _formKey.currentState!.save();
    if (!acceptPrivacy) return true;
    return false;
  }

  void showError(String mess) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            AppLocalizations.of(context).translate("attenzione"),
            textAlign: TextAlign.center,
          ),
          content: Text(mess),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("OK",
                  style:
                  TextStyle(color: Colors.grey[700], fontSize: 15.sp),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showPopUpRegistrazioneAvvenuta() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
                width: MediaQuery.of(context).size.width * .60,
                height: MediaQuery.of(context).size.height * .10,
                child: Center(
                    child: AutoSizeText(
                      AppLocalizations.of(context).translate('registrazioneAvvenuta'),
                    ))),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("OK",
                    style:
                    TextStyle(color: Colors.grey[700], fontSize: 15.sp),
                  ),
                ),
              ),
            ],
          );
        });
  }

}
