import 'dart:convert';
import 'dart:io';

import 'package:bmms/model/user.dart';
import 'package:bmms/scene/dashboard.dart';
import 'package:bmms/scene/register_view.dart';
import 'package:bmms/scene/visit_view.dart';
import 'package:bmms/utils/utils.dart';
import 'package:flutter/material.dart';
import '../api/appapi.dart';
import '../api/request.dart';
import '../constants/message.dart' as msg;
import '../constants/color.dart' as color;
import '../custom/common_ui.dart';
import '../helper/scroll_behavior.dart';
import '../model/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'forgot_password_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController txtUserEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  final _textFieldController = TextEditingController();

  void internetConnectivityCheck(String email, String password) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (email == '') {
         // login(email, password);
          if (!mounted) return;
          Dialogs.showInEng(context, 'Enter valid email id');
        }  else if(!Utils.isValidateEmail(email)){
          if (!mounted) return;
          Dialogs.showInEng(context, 'Email is invalid');
        }else if( password == ''){
          if (!mounted) return;
          Dialogs.showInEng(context, 'Enter 8 Digit Password');
        }else{
          login(email, password);
        }
      }
    } on SocketException catch (_) {
      if (!mounted) return;
      Dialogs.showInEng(context, msg.NO_INTERNET);
    }
  }

  Future<void> login(String email, String password) async {
    Dialogs.progressDialog(context);
    Map<String, String> dict = <String, String>{
      'email': email,
      'password': password
    };
    var response = await Request.postMethodCall(context, AppApi.loginurl, dict);
    Navigator.of(context).pop();
    print("loginresponse"+response.body.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      var nResponse = jsonDecode(response.body);


      if (nResponse['error']) {
        if (!mounted) return;
        if(nResponse['message'] == 'Invalid User'){
          Dialogs.showInEng(context, nResponse['message']);
        }else{
          _showDialogEmailVerify(context);
          // User user = User.fromJson(nResponse['user']);
          // Global.userInfo = user;
          Global.token = nResponse['token'];
        }
       // Dialogs.showInEng(context, nResponse['message']);
        //_showDialogEmailVerify(context);
        // User user = User.fromJson(nResponse['user']);
        // Global.userInfo = user;
        //Global.token = nResponse['token'];

        // final prefs = await SharedPreferences.getInstance();
        // await prefs.setString("user_info", response.body);
       // _showDialogEmailVerify(context);
      } else {
        final prefs = await SharedPreferences.getInstance();
        //Global.isEmailVerified = true;
        await prefs.setBool('isEmailVerified', true);

        User user = User.fromJson(nResponse['user']);
        Global.userInfo = user;
        Global.token = nResponse['token'];

        await prefs.setString("user_info", response.body);

        /*
        if (mounted) {
          // bool visit = Global.visit;
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Dash()),
              (route) => false,
            );
          /*if (visit) {
            // Navigator.pop(context);
            // Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(builder: (context) => const VisitPage()),
            //   (route) => false
            // );
          } else {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Dash()),
              (route) => false,
            );
          }*/
        }*/
        if (mounted) {
          Navigator.of(context, rootNavigator: true)
              .pushNamedAndRemoveUntil('/dashboard', (route) => false);

        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: color.drawerColor,
      body: Container(
        height: height,
        color: Colors.white.withOpacity(0.5),
        margin: const EdgeInsets.only(top: 34),
        child: ScrollConfiguration(
          behavior: ListBehavior(),
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 60),
                height: 120,
                width: 120,
                child: Image.asset('assets/bdseal.png'),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: const Text(
                  msg.SPLASH_TEXT,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: width - 20,
                margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
                child: TextField(
                  cursorColor: Colors.grey,
                  controller: txtUserEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    hintText: 'Email Address',
                    labelStyle: TextStyle(color: color.secondaryColor),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: color.buttonColor),
                    ),
                  ),
                ),
              ),
              Container(
                width: width - 20,
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  cursorColor: Colors.grey,
                  controller: txtPassword,
                  obscureText: true,
                  obscuringCharacter: '*',
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter 8 digit password',
                    labelStyle: TextStyle(color: color.secondaryColor),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: color.buttonColor),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  internetConnectivityCheck(
                      txtUserEmail.text, txtPassword.text);
                },
                child: Container(
                    margin: const EdgeInsets.only(top: 40, left: 80, right: 80),
                    height: 50,
                    decoration: BoxDecoration(
                        color: color.primaryColor,
                        borderRadius: BorderRadius.circular(28)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  GestureDetector(
                    onTap: () {
                      if (mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  ForgotPasswordScreen()),
                        );
                      }
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: color.textBtnColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    msg.REGISTER_TEXT,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()),
                        );
                      }
                    },
                    child: const Text(
                      msg.REGISTER_BTN,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: color.textBtnColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }



  resendverifyCode(bool isResend) async {
    // Map<String, String> dict = {
    //   'verify_token': _textFieldController.text,
    // };
    Dialogs.progressDialog(context);
    var response = await Request.postMethodCallWithToken(context, AppApi.sendCode, {});
    Navigator.of(context).pop();
    if (response.statusCode == 200 || response.statusCode == 201) {
      var nResponse = jsonDecode(response.body);
      print(nResponse);
      // if (!mounted) return;
      if (nResponse['success']) {
        //print(Navigator.of(context).bucket);
        if(!isResend){
          Navigator.of(context).pop();
          _showDialogCodeSubmit(context);
        }

        // Navigator.of(context, rootNavigator: true)
        //     .pushNamedAndRemoveUntil('/dashboard', (route) => false);

        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(builder: (context) => const HomeView()),
        //     (route) => false);
      }
      // Dialogs.showInEng(context, nResponse['message']);
    }
  }


  _showDialogEmailVerify(BuildContext context) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Email not Verified',style: TextStyle(fontSize: 12),),
            // content: TextField(
            //   keyboardType: TextInputType.number,
            //   controller: _textFieldController,
            //   decoration: const InputDecoration(hintText: "Input code"),
            // ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text("Verify Email"),
                onPressed: () => resendverifyCode(false),
              ),
              // ElevatedButton(
              //   child: const Text('Submit Code'),
              //   onPressed: () {
              //     if(_textFieldController.text.isEmpty){
              //
              //     }else{
              //       verifyCodeSubmit();
              //     }
              //
              //   },
              // ),
            ],
          );
        });
  }

  _showDialogCodeSubmit(BuildContext context) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Check email & submit the code to verify your email.',style: TextStyle(fontSize: 12),),
            content: TextField(
              keyboardType: TextInputType.number,
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: "Input code"),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text("Resend"),
                onPressed: () => resendverifyCode(true),
              ),
              ElevatedButton(
                child: const Text('Submit Code'),
                onPressed: () {
                  if(_textFieldController.text.isEmpty){

                  }else{
                    verifyCodeSubmit();
                  }

                },
              ),
            ],
          );
        });
  }

  verifyCodeSubmit() async {
    Dialogs.progressDialog(context);
    Map<String, String> dict = {
      'verify_token': _textFieldController.text,
    };
    var response = await Request.postMethodCallWithToken(context, AppApi.verifycodesubmit, dict);
    Navigator.of(context).pop();
    if (response.statusCode == 200 || response.statusCode == 201) {
      var nResponse = jsonDecode(response.body);
      print(nResponse);
      // if (!mounted) return;
      if (nResponse['message'].toString().isNotEmpty) {
        //print(Navigator.of(context).bucket);
        if(nResponse['message'].toString() == 'Invalid Verification Code!'){
          Dialogs.showInEng(context, nResponse['message'].toString());
        }else if(nResponse['message'].toString() == 'Email Verification Successfully Done!'){
          Navigator.of(context).pop();
          Dialogs.showInEng(context, nResponse['message']);
          login(txtUserEmail.text, txtPassword.text);
          // Navigator.of(context, rootNavigator: true)
          //     .pushNamedAndRemoveUntil('/dashboard', (route) => false);
        }
        //Navigator.of(context).pop();


        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(builder: (context) => const HomeView()),
        //     (route) => false);
      }
      // Dialogs.showInEng(context, nResponse['message']);
    }
  }

}
