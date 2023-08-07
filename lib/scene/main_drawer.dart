import 'dart:convert';
import 'dart:io';

import 'package:bmms/model/user.dart';
import 'package:bmms/scene/contact_us.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_redirect/store_redirect.dart';
import '../api/appapi.dart';
import '../api/request.dart';
import '../constants/color.dart' as color;
import 'package:bmms/scene/innovation_team.dart';
import 'package:bmms/scene/visit_view.dart';
import 'package:flutter/material.dart';

import '../custom/common_ui.dart';
import '../localization/language_constants.dart';
import '../model/globals.dart';
import '../model/language.dart';
import 'about_view.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  String langTileTitle = 'English';
  bool initialTogglePos = true;
  Future<void> logout() async {
    // var response =
    //     await Request.getMethodCallWithToken(context, AppApi.logout, {});
    // if (response.statusCode == 200 || response.statusCode == 201) {
    //   var nResponse = jsonDecode(response.body);
    //   print(nResponse);
    // }

    Global.userInfo = User();
    Global.token = '';

    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user_info');
    prefs.remove('isEmailVerified');

    if (!mounted) return;
    Navigator.pop(context);
    Global.visit = false;

    if (mounted) {
      Navigator.of(context, rootNavigator: true)
          .pushNamedAndRemoveUntil('/welcome', (route) => false);
    }
  }

  @override
  void initState() {
    getLanguageTitle();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: color.drawerColor,
      child: ListView(
        children: [
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    // shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/bdseal.png"),
                    ),
                  ),
                  margin: const EdgeInsets.only(top: 40, bottom: 20),
                  height: 150,
                  width: 150,
                  alignment: Alignment.center,
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  decoration: const BoxDecoration(color: Colors.grey),
                  // margin: const EdgeInsets.only(left: 20, right: 20),
                )
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.list,
              // color: Colors.white,
            ),
            title: const Text(
              'Category',
              style: TextStyle(
                fontSize: 18,
                // color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.airport_shuttle,
              // color: Colors.white,
            ),
            title: const Text(
              'Visit Museum',
              style: TextStyle(
                fontSize: 18,
                // color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Global.visit = true;
              if (mounted) {
                //if (Global.token.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const VisitPage(),
                        ),
                  );
                // } else {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => const LoginPage()),
                //   );
                // }
              }
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.supervisor_account,
              // color: Colors.white,
            ),
            title: const Text(
              'Team Innovator',
              style: TextStyle(
                fontSize: 18,
                // color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Global.visit = false;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InnovationTeam()),
              );
            },
          ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.spa,
          //     // color: Colors.white,
          //   ),
          //   title: const Text(
          //     'Technical Team',
          //     style: TextStyle(
          //       fontSize: 18,
          //       // color: Colors.white,
          //     ),
          //   ),
          //   onTap: () {
          //     Navigator.pop(context);
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => const TechnicalTeam()),
          //     );
          //   },
          // ),

          // ListTile(
          //   leading: const Icon(
          //     Icons.photo,
          //     // color: Colors.white,
          //   ),
          //   title: const Text(
          //     'Photo Gallery',
          //     style: TextStyle(
          //       fontSize: 18,
          //       // color: Colors.white,
          //     ),
          //   ),
          //   onTap: () {
          //     Navigator.pop(context);
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => const PhotoGallery()),
          //     );
          //   },
          // ),

          ListTile(
            leading: const Icon(
              Icons.person,
              // color: Colors.white,
            ),
            title: const Text(
              'About Us',
              style: TextStyle(
                fontSize: 18,
                // color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Global.visit = false;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.phone,
              // color: Colors.white,
            ),
            title: const Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 18,
                // color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Global.visit = false;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContactUs()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.rate_review,
              // color: Colors.white,
            ),
            title: const Text(
              'Rate/Review App',
              style: TextStyle(
                fontSize: 18,
                // color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              sendFeedBack();
            },
          ),

          // ListTile(
          //   leading: const Icon(
          //     Icons.rate_review,
          //     // color: Colors.white,
          //   ),
          //   title: const Text(
          //     'Help',
          //     style: TextStyle(
          //       fontSize: 18,
          //       // color: Colors.white,
          //     ),
          //   ),
          //   onTap: () {
          //     Navigator.pop(context);
          //
          //   },
          // ),
      //    ListTile(
      //   leading: const Icon(
      //     Icons.toggle_on,
      //   ),
      //   title: Text(
      //     langTileTitle,
      //     style: const TextStyle(fontSize: 18),
      //   ),
      //   onTap: () async {
      //     Locale locale = await getLocale();
      //     List<Language> langList = Language.languageList();
      //     for (int i = 0; i < langList.length; i++) {
      //       Language lang = langList[i];
      //       // print('${lang.languageCode} - ${locale.languageCode}');
      //       if (lang.languageCode != locale.languageCode) {
      //         _changeLanguage(lang);
      //       }
      //     }
      //
      //     await Future.delayed(const Duration(milliseconds: 500));
      //
      //     if (!mounted) return;
      //     Navigator.pop(context);
      //   },
      // ),

          // Visibility(
          //   visible: Global.token != '',
          //   child: ListTile(
          //     leading: const Icon(
          //       Icons.schedule_outlined,
          //       // color: Colors.white,
          //     ),
          //     title: const Text(
          //       'My Appointment',
          //       style: TextStyle(
          //         fontSize: 18,
          //         // color: Colors.white,
          //       ),
          //     ),
          //     onTap: () {
          //       Navigator.pop(context);
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => const AppointmentScreen()),
          //       );
          //     },
          //   ),
          // ),
          Visibility(
            visible: Global.token != '',
            child: ListTile(
              leading: const Icon(
                Icons.add_to_home_screen_rounded,
                // color: Colors.white,
              ),
              title: const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 18,
                  // color: Colors.white,
                ),
              ),
              onTap: () async {
                var result = await Dialogs.logoutDialogCallBack(context);
                if (result) {
                  if (!mounted) return;
                  logout();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void sendFeedBack() {
    StoreRedirect.redirect(
      androidAppId: "com.bmm.bmms",
     // iOSAppId: "585027354",
    );
  }
  void _changeLanguage(Language language) async {
    // setState(() {
    //   initialTogglePos = language.languageCode == 'en';
    //   langTileTitle = language.languageCode == 'en' ? 'English' : 'বাংলা';
    // });
    Locale _locale = await setLocale(language.languageCode);
    // HomeMainPage.setLocale(context, _locale);
  }
  void getLanguageTitle() async {
    Locale locale = await getLocale();
    //initialTogglePos = locale.languageCode == 'en';
    langTileTitle = locale.languageCode == 'en' ? 'English' : 'বাংলা';

    setState(() {});
  }
}
