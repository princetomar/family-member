import 'package:flutter/material.dart';

class NotActiveMemberCard extends StatelessWidget {
  late String name;
  late int age;
  late String relationShipStatus;
  late String fatherName;
  late String profession;
  late String uniqueID;

  NotActiveMemberCard({
    required this.name,
    required this.age,
    required this.relationShipStatus,
    required this.fatherName,
    required this.profession,
    required this.uniqueID,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color(0xFF0A0908),
          Color(0xFFA63A50),
        ]),
        border: Border.all(
          color: Color(0xFFFE6D73).withOpacity(0.7),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RichText(
            text: TextSpan(
              text: 'Name: ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFA9927D),
              ),
              children: [
                TextSpan(
                  text: '$name',
                  style: TextStyle(
                    color: Color(0xFFF0E7D8),
                  ),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'Age: ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFA9927D),
              ),
              children: [
                TextSpan(
                  text: '${age.toString()}',
                  style: TextStyle(
                    color: Color(0xFFF0E7D8),
                  ),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'Unique ID: ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFA9927D),
              ),
              children: [
                TextSpan(
                  text: '$uniqueID',
                  style: TextStyle(
                    color: Color(0xFFF0E7D8),
                  ),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'RelationShipStatus: ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFA9927D),
              ),
              children: [
                TextSpan(
                  text: '$relationShipStatus',
                  style: TextStyle(
                    color: Color(0xFFF0E7D8),
                  ),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'FatherName: ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFA9927D),
              ),
              children: [
                TextSpan(
                  text: '$fatherName',
                  style: TextStyle(
                    color: Color(0xFFF0E7D8),
                  ),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'Profession: ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFA9927D),
              ),
              children: [
                TextSpan(
                  text: '$profession',
                  style: TextStyle(
                    color: Color(0xFFF0E7D8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
