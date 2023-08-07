import 'dart:convert';

import 'package:bmms/localization/language_constants.dart';
import 'package:bmms/scene/dashboard.dart';
import 'package:bmms/scene/home_view.dart';
import 'package:bmms/scene/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/message.dart' as msg;
import '../constants/color.dart' as color;
import '../model/globals.dart';
import '../model/user.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _navigateToHome();
  }

  Route _welcomeRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const WelcomePage(),
      reverseTransitionDuration: Duration.zero,
      transitionDuration: const Duration(milliseconds: 1000),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  Route _homeRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const Dash(),
      reverseTransitionDuration: Duration.zero,
      transitionDuration: const Duration(milliseconds: 1000),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  _navigateToHome() async {
    final prefs = await SharedPreferences.getInstance();
    String response = prefs.getString("user_info").toString();
    bool? isverify =  prefs.getBool('isEmailVerified');
    if(isverify != null ){
      if(isverify){
        if (response.isNotEmpty && response != 'null') {
          var res = jsonDecode(response);
          User user = User.fromJson(res['user']);
          Global.userInfo = user;
          Global.token = res['token'];

          await Future.delayed(const Duration(milliseconds: 2500), () {
            if (mounted) {
              Navigator.of(context).pushReplacement(_homeRoute());
            }
          });
        }
      } else {
        await Future.delayed(const Duration(milliseconds: 2500), () {
          if (mounted) {
            Navigator.of(context).pushReplacement(_welcomeRoute());
          }
        });
      }
    }else {
      await Future.delayed(const Duration(milliseconds: 2500), () {
        if (mounted) {
          Navigator.of(context).pushReplacement(_welcomeRoute());
        }
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(color: color.primaryColor),
        child: Stack(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Image.asset(
            //   'assets/bdlogo.png',
            //   height: 150,
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            //
            // Image.asset(
            //   'assets/bdsealw.png',
            //   height: 150,
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            Align(
              alignment: Alignment.center,
              child:  Text(
                getTranslated(context, "app_name")??'',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Museum',
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // const SizedBox(
            //   height: 50,
            // ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 190,
               // margin: EdgeInsets.only(bottom: 60),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/bdlogo.png',
                          height: 90,
                        ),
                        const SizedBox(
                          width: 20,
                        ),

                        Image.asset(
                          'assets/bdsealw.png',
                          height: 90,
                        ),
                      ],
                    ),
                    SizedBox(height: 50,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Design and developed by:  '),
                        Image.asset(
                          'assets/nano.jpeg',
                          height: 35,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
