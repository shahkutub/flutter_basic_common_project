import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../constants/message.dart' as msg;
import '../custom/common_ui.dart';
import '../model/globals.dart';

class Request {
  static Future<Response> postMethodCall(
      BuildContext context, String urlString, Map<String, dynamic> dict) async {
    // dict['token'] = Global.accessToken;
    var url = Uri.parse(urlString);
    print(url);
    // Dialogs.showInEng(context, url.toString());
    try {
      var response = await http
          .post(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Accept': 'application/json',
            },
            body: jsonEncode(dict),
          )
          .timeout(const Duration(minutes: 2));
      
      if (response.statusCode == 200) {
          return response;
      } else if (response.statusCode == 401) {
        // EasyLoading.dismiss();
      } else if (response.statusCode == 404) {
        Dialogs.showInEng(context, msg.SERVER_ERROR);
        // EasyLoading.dismiss();
      } else if (response.statusCode == 500) {
        Dialogs.showInEng(context, msg.INTERNAL_ERROR);
        // EasyLoading.dismiss();
      } else {
        print(response.statusCode);
        // EasyLoading.dismiss();
      }
      return response;
    } on SocketException catch (e) {
      Dialogs.showInEng(context, msg.SERVER_CONNECT_ERROR);
      // EasyLoading.dismiss();
      throw Exception(e.message);
    } on TimeoutException catch (e) {
      Dialogs.showInEng(context, msg.SERVER_CONNECT_ERROR);
      // EasyLoading.dismiss();
      throw Exception(e.toString());
    } catch (e) {
      Dialogs.showInEng(context, e.toString());
      // EasyLoading.dismiss();
      throw Exception(e.toString());
    }
  }

  static Future<Response> postMethodCallWithToken(
      BuildContext context, String urlString, Map<String, dynamic> dict) async {
    // dict['token'] = Global.accessToken;
    var url = Uri.parse(urlString);
    print(url);
    print(Global.token);
    // Dialogs.showInEng(context, url.toString());
    try {
      var response = await http
          .post(
            url,
            headers: <String, String>{
              'Authorization': 'Bearer ${Global.token}',
              'Content-Type': 'application/json; charset=UTF-8',
              'Accept': 'application/json',
            },
            body: jsonEncode(dict),
          )
          .timeout(const Duration(minutes: 2));
      
      if (response.statusCode == 200) {
          return response;
      } else if (response.statusCode == 401) {
        // EasyLoading.dismiss();
      } else if (response.statusCode == 404) {
        Dialogs.showInEng(context, msg.SERVER_ERROR);
        // EasyLoading.dismiss();
      } else if (response.statusCode == 500) {
        Dialogs.showInEng(context, msg.INTERNAL_ERROR);
        // EasyLoading.dismiss();
      } else {
        print(response.statusCode);
        // EasyLoading.dismiss();
      }
      return response;
    } on SocketException catch (e) {
      Dialogs.showInEng(context, msg.SERVER_CONNECT_ERROR);
      // EasyLoading.dismiss();
      throw Exception(e.message);
    } on TimeoutException catch (e) {
      Dialogs.showInEng(context, msg.SERVER_CONNECT_ERROR);
      // EasyLoading.dismiss();
      throw Exception(e.toString());
    } catch (e) {
      Dialogs.showInEng(context, e.toString());
      // EasyLoading.dismiss();
      throw Exception(e.toString());
    }
  }

  static Future<Response> getMethodCall(
      BuildContext context, String urlString, Map<String, dynamic> dict) async {
    var url = Uri.parse(urlString);
    var fUri = dict.isNotEmpty ? url.replace(queryParameters: dict) : url;
    print(fUri);
    try {
      var response = await http.get(
        fUri,
        headers: <String, String>{
          //'Authorization': 'Bearer ',//${Global.accessToken}
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
          return response;
      } else if (response.statusCode == 401) {
        // EasyLoading.dismiss();
      } else if (response.statusCode == 404) {
        Dialogs.showInEng(context, msg.SERVER_ERROR);
        // EasyLoading.dismiss();
      } else if (response.statusCode == 500) {
        print(response.body);
        Dialogs.showInEng(context, msg.INTERNAL_ERROR);
        // EasyLoading.dismiss();
      } else {
        // EasyLoading.dismiss();
      }
      return response;
    } on SocketException catch (e) {
      Dialogs.showInEng(context, msg.SERVER_CONNECT_ERROR);
      // EasyLoading.dismiss();
      throw Exception(e.message);
    } on TimeoutException catch (e) {
      Dialogs.showInEng(context, msg.SERVER_CONNECT_ERROR);
      // EasyLoading.dismiss();
      throw Exception(e.toString());
    } catch (e) {
      Dialogs.showInEng(context, e.toString());
      // EasyLoading.dismiss();
      throw Exception(e.toString());
    }
  }

  static Future<Response> getMethodCallWithToken(
      BuildContext context, String urlString, Map<String, dynamic> dict) async {
    var url = Uri.parse(urlString);
   // var fUri = dict.isNotEmpty ? url.replace(queryParameters: dict) : url;
    var fUri = url;
    print(fUri);
    print(Global.token);
    try {
      var response = await http.get(
        fUri,
        headers: <String, String>{
          'Authorization': 'Bearer ${Global.token}',
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
          return response;
      } else if (response.statusCode == 401) {
        // EasyLoading.dismiss();
      } else if (response.statusCode == 404) {
        Dialogs.showInEng(context, msg.SERVER_ERROR);
        // EasyLoading.dismiss();
      } else if (response.statusCode == 500) {
        print(response.body);
        Dialogs.showInEng(context, msg.INTERNAL_ERROR);
        // EasyLoading.dismiss();
      } else {
        // EasyLoading.dismiss();
      }
      return response;
    } on SocketException catch (e) {
      Dialogs.showInEng(context, msg.SERVER_CONNECT_ERROR);
      // EasyLoading.dismiss();
      throw Exception(e.message);
    } on TimeoutException catch (e) {
      Dialogs.showInEng(context, msg.SERVER_CONNECT_ERROR);
      // EasyLoading.dismiss();
      throw Exception(e.toString());
    } catch (e) {
      Dialogs.showInEng(context, e.toString());
      // EasyLoading.dismiss();
      throw Exception(e.toString());
    }
  }
}
