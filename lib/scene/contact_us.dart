import 'package:flutter/material.dart';
import '../constants/color.dart' as color;

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: color.scafColor.withOpacity(0.5),
      appBar: AppBar(
        title: const Text('Contact Us'),
        centerTitle: true,
      ),
      body: ListView(shrinkWrap: true, children: [

        // SizedBox(
        //   width: width,
        //   child: const Text(
        //     'Government of the People\'s Republic of Bangladesh\nMinistry of Power, Energy and Mineral Resources\nDepartment of Energy and Mineral Resources\nGeological Survey of Bangladesh (GSB)',
        //     style: TextStyle(
        //       fontSize: 15,
        //     ),
        //     textAlign: TextAlign.center,
        //   ),
        // ),
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
          'Communication',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'MuseumN',
              color: color.titleTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: width,
          child: const Text(
            'Geological Survey of Bangladesh (GSB)\n153 Pioneer Road, Segunbagicha, Dhaka 1000\nFax: + 80-2-9339309;\nE-mail:geologicalsurveybd@gmail.com;\nWeb:www.gsb.gov.bd\nFacebook page: www.facebook.com/\nbangladeshgeologicalsurvey',
            style: TextStyle(
              fontSize: 17,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          margin: const EdgeInsets.all(20),
          width: width,
          height: 100,
          decoration: BoxDecoration(
            color: color.scafColor.withOpacity(0.6),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 1),
                blurRadius: 5,
                color: Colors.black.withOpacity(0.3),
              ),
            ],
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, top: 10),
                alignment: Alignment.centerLeft,
                child: const Text.rich(TextSpan(text: '', children: [
                  TextSpan(
                      text: 'Designation: ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: 'Director General', style: TextStyle(fontSize: 16))
                ])),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, top: 10),
                alignment: Alignment.centerLeft,
                child: const Text.rich(TextSpan(text: '', children: [
                  TextSpan(
                      text: 'Phone: ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  TextSpan(text: '880249349502', style: TextStyle(fontSize: 16))
                ])),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, top: 10),
                alignment: Alignment.centerLeft,
                child: const Text.rich(TextSpan(text: '', children: [
                  TextSpan(
                      text: 'Email: ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: 'geologicalsurveybd@gmail.com',
                      style: TextStyle(fontSize: 16))
                ])),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
