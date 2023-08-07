import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../api/appapi.dart';
import '../api/request.dart';
import '../constants/color.dart' as color;
import '../constants/message.dart' as msg;
import '../custom/common_ui.dart';
import '../helper/scroll_behavior.dart';
import '../model/globals.dart';
import 'home_view.dart';
import 'login_view.dart';

class VisitPage extends StatefulWidget {
  const VisitPage({super.key});

  @override
  State<VisitPage> createState() => _VisitPageState();
}

class _VisitPageState extends State<VisitPage> {
  TextEditingController txtPhoneNo = TextEditingController();
  TextEditingController txtDate = TextEditingController();

  DateTime selectedDate = DateTime.now();
  DateTime firstDate = DateTime.now();
  DateTime lastDate = DateTime(2101);
  final fe = DateFormat('dd-MM-yyyy');

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: color.buttonColor, // <-- SEE HERE
              onPrimary: color.primaryColor, // <-- SEE HERE
              onSurface: color.buttonColor, // <-- SEE HERE
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        txtDate.text = fe.format(picked);
      });
    }
  }

  void internetConnectivityCheck() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        visitInfoSubmit();
      }
    } on SocketException catch (_) {
      if (!mounted) return;
      Dialogs.showInEng(context, msg.NO_INTERNET);
    }
  }

  Future<void> visitInfoSubmit() async {
    Map<String, String> dict = {
      'name': Global.userInfo.name ?? 'No Name',
      'phone': txtPhoneNo.text,
      'visit_date': txtDate.text
    };
    var response =
        await Request.postMethodCallWithToken(context, AppApi.visiturl, dict);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var nResponse = jsonDecode(response.body);

      if (!mounted) return;
      if (!nResponse['error']) {
        print(Navigator.of(context).bucket);
        // Navigator.of(context).pop();
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(builder: (context) => const HomeView()),
        //     (route) => false);
      }
      Dialogs.showInEng(context, nResponse['message']);
    }
  }

  @override
  void initState() {
    super.initState();
    txtPhoneNo.text = Global.userInfo.mobile ?? '';
    txtDate.text = fe.format(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: color.scafColor.withOpacity(0.5),
      appBar: AppBar(
        title: const Text('Visit Museum'),
        centerTitle: true,
      ),
      body: Container(
        height: height,
        color: Colors.white.withOpacity(0.5),
        margin: const EdgeInsets.only(top: 10),
        child: ScrollConfiguration(
          behavior: ListBehavior(),
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                  width: width - 20,
                  margin: const EdgeInsets.only(top: 20, left: 25, right: 20),
                  child: Text(
                    'Name: ' + (Global.userInfo.name ?? 'No Name'),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  )),
              Container(
                width: width - 20,
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
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
                  controller: txtDate,
                  readOnly: true,
                  decoration: const InputDecoration(
                      labelText: 'Arrival Date',
                      hintText: 'Arrival Date',
                      labelStyle: TextStyle(color: color.secondaryColor),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: color.buttonColor),
                      ),
                      suffixIcon: Icon(Icons.calendar_month)),
                  onTap: () {
                    _selectDate(context);
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  if (Global.token.isEmpty) {
                    if (txtPhoneNo.text.isEmpty) {
                      Dialogs.showInEng(context, 'Give Phone no First');
                    } else {
                      if (mounted) {
                        Navigator.of(context, rootNavigator: true)
                            .pushNamedAndRemoveUntil(
                                '/login', (route) => false);
                      }
                    }
                  } else {
                    internetConnectivityCheck();
                  }
                },
                child: Container(
                    margin: const EdgeInsets.only(top: 40, left: 80, right: 80),
                    height: 50,
                    decoration: BoxDecoration(
                        color: color.buttonColor,
                        borderRadius: BorderRadius.circular(28)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Submit',
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

  Future<void> _showSimpleDialog() async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return LoginPage();
        });
  }
}
