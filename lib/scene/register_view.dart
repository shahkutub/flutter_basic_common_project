import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/appapi.dart';
import '../api/request.dart';
import '../constants/message.dart' as msg;
import '../constants/color.dart' as color;
import '../custom/common_ui.dart';
import '../helper/scroll_behavior.dart';
import '../model/globals.dart';
import '../model/registration_response.dart';
import '../model/user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController txtUserName = TextEditingController();
  TextEditingController txtUserEmail = TextEditingController();
  TextEditingController txtPhoneNo = TextEditingController();
  TextEditingController txtDepartment = TextEditingController();
  TextEditingController txtProfession = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtCPassword = TextEditingController();

  final _textFieldController = TextEditingController();


  void checkDataAvailabilityandRegister() {
    String name = txtUserName.text;
    String email = txtUserEmail.text;
    String phoneNo = txtPhoneNo.text;
    String department = txtDepartment.text;
    String profession = txtProfession.text;
    String password = txtPassword.text;
    String cPassword = txtCPassword.text;

    if (name != '' &&
        email != '' &&
        phoneNo != '' &&
        department != '' &&
        profession != '' &&
        password != '' &&
        cPassword != '') {
      final bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);
      if (emailValid) {
        Map<String, String> dict = <String, String>{
          'name': name,
          'email': email,
          'mobile': phoneNo,
          'profession': profession,
          'department': department,
          'password': password,
          'password_confirmation': cPassword
        };
        print(dict);
        internetConnectivityCheck(dict);
      } else {
        Dialogs.showInEng(context, msg.VALID_EMAIL);
      }
    } else {
      Dialogs.showInEng(context, msg.FILL_UP_FORM);
    }
  }

  void internetConnectivityCheck(Map<String, String> dict) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        register(dict);
      }
    } on SocketException catch (_) {
      if (!mounted) return;
      Dialogs.showInEng(context, msg.NO_INTERNET);
    }
  }

  Future<void> register(Map<String, String> dict) async {

    Dialogs.progressDialog(context);
    var response = await Request.postMethodCall(context, AppApi.registerurl, dict);
    Navigator.of(context).pop();
    if (response.statusCode == 200 || response.statusCode == 201) {
      var nResponse = jsonDecode(response.body);
      print(nResponse);
      if (response.body.contains('success') && !nResponse['success']) {
       // if (!mounted) return;
        //Dialogs.showInEng(context, nResponse['message']);
        try {
          Errors error = Errors.fromJson(nResponse['errors']);
          Dialogs.showInEng(context, error.msg.toString());
        } on Exception catch (_) {
          // make it explicit that this function can throw exceptions
          rethrow;
        }



      } else {
        User user = User.fromJson(nResponse['user']);
        Global.userInfo = user;
        Global.token = nResponse['token'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("user_info", response.body);
        await prefs.setBool('isEmailVerified', true);
        if (mounted) {
          _showTextInputDialog(context);
         // Dialogs.showInEng(context, 'Verify email');
         //  Navigator.of(context, rootNavigator: true)
         //      .pushNamedAndRemoveUntil('/dashboard', (route) => false);
        }
        /*if (mounted) {
          bool visit = Global.visit;
          if (visit) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const VisitPage()),
              (route) => false,
            );
            // Navigator.popUntil(context, ModalRoute.withName('visit'));
          } else {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Dash()),
              (route) => false,
            );
          }
        }*/
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
    return Scaffold(
      backgroundColor: color.drawerColor,
      body: Container(
        color: Colors.white.withOpacity(0.5),
        margin: const EdgeInsets.only(top: 34),
        child: ScrollConfiguration(
          behavior: ListBehavior(),
          child: ListView(
            shrinkWrap: true,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () async {
                    Navigator.of(context).pop();
                  },
                  child: const SizedBox(
                    width: 60,
                    height: 40,
                    child: Icon(
                      Icons.arrow_back_ios,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
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
                  controller: txtUserName,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    hintText: 'User Name',
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
                  controller: txtPhoneNo,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Mobile No',
                    hintText: 'Mobile No',
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
                  controller: txtProfession,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    labelText: 'Profession',
                    hintText: 'Profession',
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
                  controller: txtDepartment,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    labelText: 'Department',
                    hintText: 'Department',
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
                    hintText: 'Enter Password (must be 8 character long)',
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
                  controller: txtCPassword,
                  obscureText: true,
                  obscuringCharacter: '*',
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: 'Enter Confirm Password',
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
                  checkDataAvailabilityandRegister();
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
                          'Register',
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
            ],
          ),
        ),
      ),
    );
  }


   _showTextInputDialog(BuildContext context) async {
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
                onPressed: () => resendverifyCode(),
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
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isEmailVerified', true);
         Navigator.of(context).pop();
         //register(dict);
         Navigator.of(context, rootNavigator: true)
             .pushNamedAndRemoveUntil('/dashboard', (route) => false);

        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(builder: (context) => const HomeView()),
        //     (route) => false);
      }
     // Dialogs.showInEng(context, nResponse['message']);
    }
  }

  resendverifyCode() async {
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
      if (nResponse['message'].toString().isNotEmpty) {
        //print(Navigator.of(context).bucket);
        // Navigator.of(context).pop();
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

}
