import 'package:bmms/localization/app_localizations.dart';
import 'package:bmms/localization/language_constants.dart';
import 'package:bmms/scene/dashboard.dart';
import 'package:bmms/scene/login_view.dart';
import 'package:bmms/scene/navbar_scroll_hide.dart';
import 'package:bmms/scene/splash.dart';
import 'package:bmms/scene/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:imageview360/imageview360.dart';

import 'custom/custom_color.dart';
import 'constants/color.dart' as color;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: color.primaryColor,
  ));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) => runApp(const MyApp()));

  // runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en', 'US');
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bangladesh Mineral Museum',
      theme: ThemeData(
        primarySwatch: CustomColor.materialColor(color.primaryColor),
      ),
      routes: {
        '/welcome': (BuildContext context) => const WelcomePage(),
        '/login': (BuildContext context) => const LoginPage(),
        '/dashboard': (BuildContext context) => const Dash()
      },
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      //home:  NavbarScroll(),
      //home:  DemoPage360(),
     // home:  CommentScreen(),
      locale: _locale,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalization.delegate
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('bn', 'BN'),
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale!.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
    );
  }
}

class DemoPage360 extends StatefulWidget {
  DemoPage360() : super();

  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage360> {
  List<ImageProvider> imageList = <ImageProvider>[];
  bool autoRotate = true;
  int rotationCount = 2;
  int swipeSensitivity = 2;
  bool allowSwipeToRotate = true;
  RotationDirection rotationDirection = RotationDirection.anticlockwise;
  Duration frameChangeDuration = Duration(milliseconds: 50);
  bool imagePrecached = false;

  @override
  void initState() {
    //* To load images from assets after first frame build up.
    WidgetsBinding.instance
        .addPostFrameCallback((_) => updateImageList(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('360'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 72.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                (imagePrecached == true)
                    ? ImageView360(
                  key: UniqueKey(),
                  imageList: imageList,
                  autoRotate: autoRotate,
                  rotationCount: rotationCount,
                  rotationDirection: RotationDirection.anticlockwise,
                  frameChangeDuration: Duration(milliseconds: 30),
                  swipeSensitivity: swipeSensitivity,
                  allowSwipeToRotate: allowSwipeToRotate,
                  onImageIndexChanged: (currentImageIndex) {
                    print("currentImageIndex: $currentImageIndex");
                  },
                )
                    : Text("Pre-Caching images..."),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Optional features:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 24),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text("Auto rotate: $autoRotate"),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text("Rotation count: $rotationCount"),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text("Rotation direction: $rotationDirection"),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                      "Frame change duration: ${frameChangeDuration.inMilliseconds} milliseconds"),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child:
                  Text("Allow swipe to rotate image: $allowSwipeToRotate"),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text("Swipe sensitivity: $swipeSensitivity"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateImageList(BuildContext context) async {
    for (int i = 1; i <= 8; i++) {
      imageList.add(AssetImage('assets/$i.JPG'));
      //* To precache images so that when required they are loaded faster.
      await precacheImage(AssetImage('assets/$i.JPG'), context);
    }
    setState(() {
      imagePrecached = true;
    });
  }
}