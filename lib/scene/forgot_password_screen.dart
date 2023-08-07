
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/color.dart' as color;
import '../constants/message.dart' as msg;

import '../custom/common_ui.dart';
import '../utils/utils.dart';
import 'login_view.dart';

class ForgotPasswordScreen extends StatefulWidget{
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController txtUserEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  final _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            topView('Forgot Password'),
            SizedBox(height: 50,),
            Container(
              width: width - 20,
              margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
              child: TextField(
                cursorColor: Colors.grey,
                controller: txtUserEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  hintText: 'Email Address',
                  labelStyle: TextStyle(color: color.secondaryColor),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: color.buttonColor),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: color.buttonColor),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),

              ),
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Back to SignIn',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: color.textBtnColor,),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30,),
            InkWell(
              onTap: () {
                if(txtUserEmail.text == ""){
                  if (!mounted) return;
                  Dialogs.showInEng(context, 'Enter valid email id');
                } else if(!Utils.isValidateEmail(txtUserEmail.text)){
                  if (!mounted) return;
                  Dialogs.showInEng(context, 'Email is invalid');
                }else{
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  VerificationCodeScreen()),
                  );
                }

              },
              child: Container(
                  margin: const EdgeInsets.only(top: 0, left: 80, right: 80),
                  height: 50,
                  width: width,
                  decoration: BoxDecoration(
                      color: color.primaryColor,
                      borderRadius: BorderRadius.circular(28)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Send',
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
          ],
        ),
      ),
    );
  }

  static Widget topView(String title) {
    return Column(
      children: [
        SizedBox(height: 100,),
        Text('${title}',style: TextStyle(fontSize: 15,
            color: color.textBtnColor,
            fontWeight: FontWeight.bold),),

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
      ],
    );
  }
}



class VerificationCodeScreen extends StatefulWidget{
  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  TextEditingController txtUserEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  final _textFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _ForgotPasswordScreenState.topView("Verification Code"),
            Container(
              width: width - 20,
              margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
              child: TextField(
                cursorColor: Colors.grey,
                controller: txtUserEmail,
                keyboardType: TextInputType.number,
                decoration:  InputDecoration(
                  labelText: 'Enter Verification Code',
                  hintText: 'Enter Verification Code',
                  labelStyle: TextStyle(color: color.secondaryColor),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: color.buttonColor),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: color.buttonColor),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (mounted) {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) =>  LoginPage()),
                      // );
                    }
                  },
                  child: const Text(
                    'Resend Code',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: color.textBtnColor),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30,),
            InkWell(
              onTap: () {
                Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  NewPasswordScreen()),
                              );
              },
              child: Container(
                  margin: const EdgeInsets.only(top: 0, left: 80, right: 80),
                  height: 50,
                  width: width,
                  decoration: BoxDecoration(
                      color: color.primaryColor,
                      borderRadius: BorderRadius.circular(28)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Send',
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
          ],
        ),
      ),
    );
  }
}


class NewPasswordScreen extends StatefulWidget{
  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  TextEditingController txtUserEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  final _textFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _ForgotPasswordScreenState.topView("New Password"),
            Container(
              width: width - 20,
              margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
              child: TextField(
                cursorColor: Colors.grey,
                controller: txtUserEmail,
                keyboardType: TextInputType.text,
                decoration:  InputDecoration(
                  labelText: 'Enter New Password',
                  hintText: 'Enter at least 8 digit',
                  labelStyle: TextStyle(color: color.secondaryColor),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: color.buttonColor),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: color.buttonColor),
                    borderRadius: BorderRadius.circular(50.0),
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
                keyboardType: TextInputType.text,
                decoration:  InputDecoration(
                  labelText: 'Enter Confirm Password',
                  hintText: 'Enter at least 8 digit',
                  labelStyle: TextStyle(color: color.secondaryColor),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: color.buttonColor),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: color.buttonColor),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),

            InkWell(
              onTap: () {
              },
              child: Container(
                  margin: const EdgeInsets.only(top: 0, left: 80, right: 80),
                  height: 50,
                  width: width,
                  decoration: BoxDecoration(
                      color: color.primaryColor,
                      borderRadius: BorderRadius.circular(28)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Send',
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
          ],
        ),
      ),
    );
  }
}

