import 'package:bmms/model/user.dart';
import 'package:flutter/material.dart';
import '../constants/color.dart' as color;
import '../constants/message.dart' as msg;

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: color.scafColor.withOpacity(0.5),
      appBar: AppBar(
        title: const Text('About Us'),
        centerTitle: true,
      ),
      body: ListView(shrinkWrap: true, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
          ],
        ),
        const Text(
          'About Us',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'MuseumN',
              color: color.titleTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 26),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          width: width,
          child: const Text(
            msg.ABOUTPAGE,
            style: TextStyle(
              fontSize: 16,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ]),
    );
  }
}
