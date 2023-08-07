import 'package:bmms/scene/contact_us.dart';
import 'package:bmms/scene/home_view.dart';
import 'package:bmms/scene/login_view.dart';
import 'package:bmms/scene/visit_view.dart';
import 'package:flutter/material.dart';

import '../model/globals.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatelessWidget {
  const TabNavigator(
      {super.key,
      required this.navigatorKey,
      required this.tabItem,
      this.onTap});
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (tabItem == "HOME") {
      child = const HomeView(
        //onTap: onTap ?? () {},
      );
    } else if (tabItem == "VISIT") {
      child = const VisitPage();
    } else {
      child = const ContactUs();
    }

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
