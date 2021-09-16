

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:report_visita_danilo/Models/User.dart';
import 'package:report_visita_danilo/Utils/authService.dart';
import 'package:report_visita_danilo/Utils/horizontaldivider.dart';
import 'package:report_visita_danilo/Utils/theme.dart';

import 'Registration.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();



  bool _isLoading = false;

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
              top: ScreenUtil().setHeight(80),
              left: ScreenUtil().setWidth(16),
              right: ScreenUtil().setWidth(16),
              bottom: ScreenUtil().setHeight(60)),
          child: Container(

            padding:EdgeInsets.only(
              top: ScreenUtil().setWidth(16),
                left: ScreenUtil().setWidth(16),
                right: ScreenUtil().setWidth(16)),
            //height: ScreenUtil().screenHeight,
            color: rvTheme.canvasColor,
            child: Column(
              children: [
                Padding(
                  padding:  EdgeInsets.all(ScreenUtil().setHeight(8)),
                  child: AutoSizeText(
                   "Effettua il logIn",
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
                          labelText: "email non valida",
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
                          labelText: "password non valida",
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                              onTap: () {},
                              child: AutoSizeText(
                                "Hai dimenticato\n la password?",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(14),
                                    fontWeight: FontWeight.w100),
                                maxLines: 2,
                              ),
                            ),
                          ),
                          Container(
                            // width: ScreenUtil().setWidth(100),
                              child: MaterialButton(
                                child: setUpButtonChild("Accedi"),
                                color: rvTheme.primaryColorDark,

                                onPressed: () {

                                  if (_formKey.currentState?.validate() ?? false) {
                                    setState(() {
                                      _isLoading = true;
                                      //logInToFb();
                                      animateButton();
                                    });
                                    print('Valid');
                                  } else {
                                    print('Invalid');
                                  }
                                },
                                elevation: 4.0,
                                minWidth: ScreenUtil().setWidth(100),
                                height: 48.0,

                              )
                          )
                        ],
                      ),

                      SizedBox(
                        height: ScreenUtil().setSp(16),
                      ),
                      HorizontalOrLine(
                          color: rvTheme.unselectedWidgetColor,
                          height: ScreenUtil().setHeight(1),
                          label: "Oppure"),
                      SizedBox(
                        height: ScreenUtil().setHeight(16),
                      ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.blue,
                            child:
                          IconButton(onPressed: (){
                            AuthService().googleLogIn();
                          }, icon: Image.asset("assets/icons8-google-24.png",color: Colors.white,)
                          )),
                        CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.blue[800],
                            child:
                            IconButton(onPressed: (){}, icon: Image.asset("assets/icons8-facebook-f-24.png",color: Colors.white,)
                            )),
                        CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.black,
                            child:
                            IconButton(onPressed: (){}, icon: Image.asset("assets/icons8-apple-logo-24.png",color: Colors.white,)
                            )),
                        CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.blue,
                            child:
                            IconButton(onPressed: (){}, icon: Image.asset("assets/icons8-linkedin-24.png",color: Colors.white,)
                            )),
                      ],
                    ),
                      SizedBox(
                        height: ScreenUtil().setHeight(12),
                      ),
                      Divider(
                        color: rvTheme.unselectedWidgetColor,
                        height: ScreenUtil().setHeight(1),
                      ) ,
                      SizedBox(
                        height: ScreenUtil().setHeight(12),
                      ),
                      Padding(
                        padding:  EdgeInsets.all(ScreenUtil().setHeight(8)),
                        child: AutoSizeText(
                          "non hai un account?",
                          maxLines: 1,
                          style: TextStyle(fontSize: ScreenUtil().setSp(24)),
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
                        child:  setUpButtonChild("Registrati"),
                        elevation: 4.0,
                        minWidth: double.infinity,
                        height: 48.0,
                      ),
                      
                    ])),
              ],
            ),
          ),
        ));
  }

  void logInToFb() {

    /*FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((result) {
      isLoading = false;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home(uid: result.user!.uid)),
      );
    }).catchError((err) {
      print(err.message);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(err.message),
              actions: [
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });*/
  }

  Widget setUpButtonChild(String _text) {
    if (!_isLoading) {
      return new Text(
        _text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      );
    } else {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    }
  }

  Future<void> animateButton() async {
    setState(() {
      _isLoading = true;
    });
    User user =
    User.init(_formKey.currentState!.fields);

   dynamic res= await AuthService().signIn(user.email!.replaceAll(new RegExp(r"\s+"), ""), user.password!, context);
   if(res!=null)
     Navigator.pop(context);

    setState(() {
      _isLoading=false;
    });
  }

}
