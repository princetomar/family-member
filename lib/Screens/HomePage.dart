import 'package:family_member/Screens/add_member_screen.dart';
import 'package:family_member/Screens/delete_member.dart';
import 'package:family_member/Screens/discard_user.dart';
import 'package:family_member/Screens/family_details.dart';
import 'package:family_member/constant/color_constants.dart';
import 'package:family_member/constant/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double _deviceHeight;
  late double _deviceWidth;
  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text('Connecle'),
          backgroundColor: Colors.pinkAccent.withOpacity(0.5),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(
                height: _deviceHeight * 0.02,
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FamilyDetails()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primarycolor, secondarycolor],
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    width: _deviceWidth * 0.6,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Family Details'),
                        Icon(Icons.family_restroom_sharp)
                      ],
                    ),
                  )),
              SizedBox(
                height: _deviceHeight * 0.02,
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddMember()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primarycolor, secondarycolor],
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    width: _deviceWidth * 0.6,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [Text('Add member'), Icon(Icons.person_add)],
                    ),
                  )),
              SizedBox(
                height: _deviceHeight * 0.02,
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ArchiveMember()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primarycolor, secondarycolor],
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    width: _deviceWidth * 0.6,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Archive member'),
                        Icon(Icons.person_remove)
                      ],
                    ),
                  )),
              SizedBox(
                height: _deviceHeight * 0.02,
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DeleteMember()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primarycolor, secondarycolor],
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    width: _deviceWidth * 0.6,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [Text('Delete member'), Icon(Icons.person_off)],
                    ),
                  )),
              SizedBox(
                height: _deviceHeight * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Connecle',
                  style: GoogleFonts.wallpoet(
                    textStyle: TextStyle(color: Colors.black87, fontSize: 50),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
