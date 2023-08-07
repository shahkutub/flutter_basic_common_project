import 'package:bmms/model/globals.dart';
import 'package:bmms/scene/dashboard.dart';
import 'package:bmms/scene/login_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/message.dart' as msg;
import '../constants/color.dart' as color;
import '../helper/scroll_behavior.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List<String> scrollImgs = [
    'assets/1.JPG',
    // 'assets/2.JPG',
    'assets/3.JPG',
    'assets/4.JPG',
    'assets/5.JPG',
    'assets/6.JPG',
    'assets/7.JPG',
    'assets/8.JPG'
  ];


  @override
  void initState() {
    final newVersion = NewVersionPlus(iOSId: 'com.bmm.bmms', androidId: 'com.bmm.bmms', androidPlayStoreCountry: "bn_BD" );
    advancedStatusCheck(newVersion);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: color.scafColor.withOpacity(0.5),
      body: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 1.0,
                viewportFraction: 0.99,
                height: height,
                onPageChanged: (index, reason) {},
                autoPlayAnimationDuration: const Duration(milliseconds: 1000)),
            items: scrollImgs
                .map((item) => SizedBox(
                      child: Center(
                          child: Image.asset(
                        item,
                        fit: BoxFit.fill,
                        scale: 0.9,
                        cacheHeight: height.toInt(),
                        cacheWidth: width.toInt(),
                        width: width,
                        height: height,
                      )),
                    ))
                .toList(),
          ),
          Container(
            height: height,
            color: Colors.white.withOpacity(0.2),
            margin: const EdgeInsets.only(top: 34),
            child: ScrollConfiguration(
              behavior: ListBehavior(),
              child: ListView(
                shrinkWrap: true,
                children: [
                  const SizedBox(
                    height: 180,
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: const Text(
                      msg.WELCOME_TEXT,
                      style: TextStyle(
                        fontFamily: 'MuseumN',
                        color: Color.fromARGB(255, 227, 227, 227),
                        // color: color.drawerColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                        shadows: [
                          Shadow(
                            offset: Offset(3.0, 3.0),
                            blurRadius: 5.0,
                            color: Color.fromARGB(255, 123, 121, 121),
                          ),
                          Shadow(
                            offset: Offset(5.0, 5.0),
                            blurRadius: 8.0,
                            color: Color.fromARGB(124, 206, 206, 209),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: height / 3.5,
                  ),
                  InkWell(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      String response = prefs.getString("user_info").toString();
                      bool? isverify =  prefs.getBool('isEmailVerified');

                      if(isverify != null){
                        if(isverify!){
                          if (response.isNotEmpty && response != 'null') {
                            if (mounted) {
                              Navigator.of(context, rootNavigator: true)
                                  .pushNamedAndRemoveUntil(
                                  '/dashboard', (route) => false);
                            }
                          } else {
                            // if (mounted) {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => const LoginPage()),
                            //   );
                            // }
                            if (mounted) {
                              Navigator.of(context).pushNamed('/login');
                            }
                          }
                        }else {
                          // if (mounted) {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const LoginPage()),
                          //   );
                          // }
                          if (mounted) {
                            Navigator.of(context).pushNamed('/login');
                          }
                        }
                      }else {
                        // if (mounted) {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const LoginPage()),
                        //   );
                        // }
                        if (mounted) {
                          Navigator.of(context).pushNamed('/login');
                        }
                      }


                    },
                    child: Container(
                        margin:
                            const EdgeInsets.only(top: 30, left: 80, right: 80),
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
                  InkWell(
                    onTap: () {
                      // if (mounted) {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(builder: (context) => const Dash()),
                      //   );
                      // }
                      if (mounted) {
                        Navigator.of(context).pushNamed('/dashboard');
                      }
                    },
                    child: Container(
                        margin:
                            const EdgeInsets.only(top: 30, left: 80, right: 80),
                        height: 50,
                        decoration: BoxDecoration(
                            color: color.primaryColor,
                            borderRadius: BorderRadius.circular(28)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Guest',
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
                    height: 40,
                  ),

                ],
              ),
            ),
          ),
        ],
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
