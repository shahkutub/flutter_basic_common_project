import 'package:flutter/material.dart';
import '../constants/color.dart' as color;
import '../model/user.dart';

class InnovationTeam extends StatefulWidget {
  const InnovationTeam({super.key});

  @override
  State<InnovationTeam> createState() => _InnovationTeamState();
}

class _InnovationTeamState extends State<InnovationTeam> {

  List<Team> members = [];

  @override
  void initState() {
    super.initState();
    Team member = Team(name: 'Md. Sohel Rana', image: 'assets/a.JPG', designation: 'Deputy Director', team: 'Team Leader & Cheif Innovator', officeName: 'Geological Survey of Bangladesh');
    members.add(member);
    Team member1 = Team(name: 'Md. Mohi Uddin', image: 'assets/b.JPG', designation: 'Assistant Director', team: 'Innovator', officeName: 'Geological Survey of Bangladesh');
    members.add(member1);
    Team member2 = Team(name: 'Md. Ahsan Habib', image: 'assets/c.JPG', designation: 'Assistant Director', team: 'Innovator', officeName: 'Geological Survey of Bangladesh');
    members.add(member2);
  }
  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: color.scafColor.withOpacity(0.7),
      appBar: AppBar(
        title: const Text('Team Innovator'),
        centerTitle: true,
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: members.length,
        itemBuilder: (BuildContext context, int index) {
          Team member = members[index];
          return Card(
            color: color.drawerColor,
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width,
                    height: width / 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Image.asset(
                        member.image ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(
                      member.name ?? 'No Name',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      member.designation ?? '',
                      style: const TextStyle(
                          fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      member.team ?? '',
                      style: const TextStyle(
                          fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      member.officeName ?? '',
                      style: const TextStyle(
                          fontSize: 17),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}