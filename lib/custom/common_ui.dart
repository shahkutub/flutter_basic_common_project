import 'package:flutter/material.dart';

class Dialogs {
  static Future<void> showInBn(BuildContext pContext, String message) {
    return showDialog<void>(
      context: pContext,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'সতর্কবার্তা',
            style: TextStyle(
              fontFamily: 'Nikosh',
              fontSize: 24,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  message,
                  style: const TextStyle(
                    fontFamily: 'Nikosh',
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'ঠিক আছে',
                style: TextStyle(
                  fontFamily: 'Nikosh',
                  fontSize: 22,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> showInEng(BuildContext pContext, String message) {
    return showDialog<void>(
      context: pContext,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK', style: TextStyle(color: Colors.black),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<bool> logoutDialogCallBack(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Alert',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Do you want to logout?',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          actions: [
            TextButton(
              child: const Text(
                'Yes',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            TextButton(
              child: const Text(
                'No',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> dialogVerifyEmail(BuildContext pContext, String code) {
    return showDialog<void>(
      context: pContext,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(code),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK', style: TextStyle(color: Colors.black),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static progressDialog(BuildContext context){
    showDialog(
      // The user CANNOT close this dialog  by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // The loading indicator
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('Loading...')
                ],
              ),
            ),
          );
        });
  }

}
