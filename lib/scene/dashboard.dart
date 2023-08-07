import 'package:bmms/scene/tab_navigator.dart';
import 'package:flutter/material.dart';
import 'package:new_version_plus/new_version_plus.dart';
import '../constants/color.dart' as color;
import '../model/globals.dart';

class Dash extends StatefulWidget {
  const Dash({super.key});

  @override
  State<Dash> createState() => _DashState();
}

int currentIndexOfNavigation = 0;
String currentPage = "HOME";
final List<String> screenNames = ["HOME", "CONTACT", "VISIT"];
final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
  "HOME": GlobalKey<NavigatorState>(),
  "CONTACT": GlobalKey<NavigatorState>(),
  "VISIT": GlobalKey<NavigatorState>(),
};

class _DashState extends State<Dash> {
  @override
  void initState() {
    super.initState();
    final newVersion = NewVersionPlus(iOSId: 'com.bmm.bmms', androidId: 'com.bmm.bmms', androidPlayStoreCountry: "bn_BD" );
    advancedStatusCheck(newVersion);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void selectedItem(String tabItem, int index) {
    if (tabItem == currentPage) {
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        currentPage = screenNames[index];
        currentIndexOfNavigation = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool showFloatingBtn = MediaQuery.of(context).viewInsets.bottom == 0;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[currentPage]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (currentPage != "HOME") {
            selectedItem("HOME", 1);

            return false;
          }
        }
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        extendBody: true,
        backgroundColor: color.titleTextColor,
        body: Stack(children: <Widget>[
          _buildOffstageNavigator("HOME",
              onTap: () => selectedItem(screenNames[0], 0)),
          _buildOffstageNavigator("CONTACT"),
          _buildOffstageNavigator("VISIT"),
        ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: showFloatingBtn ? FloatingActionButton(
          backgroundColor: color.primaryColor,
          onPressed: () => selectedItem(screenNames[0], 0),
          tooltip: 'Home',
          child: const Icon(Icons.home, size: 30, color: Colors.white,),
        ) : null,
        bottomNavigationBar: BottomAppBar(
            notchMargin: 8.0,
            elevation: 0,
            color: color.primaryColor,
            shape: const CircularNotchedRectangle(),
            child: Container(
              height: 50,
              width: width,
              color: color.primaryColor.withAlpha(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 50,
                    width: (width / 2) - 36,
                    child: InkWell(
                      onTap: () {
                        Global.visit = true;
                        selectedItem(screenNames[2], 2);
                      }, 
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.airport_shuttle, size: 20, color: Colors.white,),
                              SizedBox(height: 4,),
                              Text(
                                "VISIT",
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              )
                            ]),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: (width / 2) - 36,
                    child: InkWell(
                      onTap: () => selectedItem(screenNames[1], 1),
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.call, size: 20, color: Colors.white,),
                              SizedBox(height: 4,),
                              Text(
                                "CONTACT",
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              )
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget _buildOffstageNavigator(String tabItem, {VoidCallback? onTap}) {
    return Offstage(
      offstage: currentPage != tabItem,
      child: TabNavigator(
        onTap: onTap,
        navigatorKey: _navigatorKeys[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }

  advancedStatusCheck(NewVersionPlus newVersion) async {
    final status = await newVersion.getVersionStatus();
    if (status != null) {
      debugPrint(status.releaseNotes);
      debugPrint(status.appStoreLink);
      debugPrint(status.localVersion);
      debugPrint(status.storeVersion);
      debugPrint(status.canUpdate.toString());
      if(status.canUpdate){
        newVersion.showUpdateDialog(
          context: context,
          versionStatus: status,
          dialogTitle: 'Update Available',
          dialogText: 'You can now update this app from ${status.localVersion} to ${status.storeVersion}',
          launchModeVersion: LaunchModeVersion.external,
          allowDismissal: false,
        );
      }

    }
  }
}