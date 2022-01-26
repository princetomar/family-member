import 'package:flutter/material.dart';

class MemberCard extends StatelessWidget {
  late String name;
  late int age;
  late String relationShipStatus;
  late String fatherName;
  late String profession;
  late String uniqueID;

  MemberCard({
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
          Color(0xFFF44174).withOpacity(0.9),
          Color(0xFFFA7E61).withOpacity(0.7),
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
                color: Color(0xFFA80874),
              ),
              children: [
                TextSpan(
                  text: '$name',
                  style: TextStyle(
                    color: Color(0xFFB7FDFE),
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
                color: Color(0xFFA80874),
              ),
              children: [
                TextSpan(
                  text: '${age.toString()}',
                  style: TextStyle(
                    color: Color(0xFFB7FDFE),
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
                color: Color(0xFFA80874),
              ),
              children: [
                TextSpan(
                  text: '$uniqueID',
                  style: TextStyle(
                    color: Color(0xFFB7FDFE),
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
                color: Color(0xFFA80874),
              ),
              children: [
                TextSpan(
                  text: '$relationShipStatus',
                  style: TextStyle(
                    color: Color(0xFFB7FDFE),
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
                color: Color(0xFFA80874),
              ),
              children: [
                TextSpan(
                  text: '$fatherName',
                  style: TextStyle(
                    color: Color(0xFFB7FDFE),
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
                color: Color(0xFFA80874),
              ),
              children: [
                TextSpan(
                  text: '$profession',
                  style: TextStyle(
                    color: Color(0xFFB7FDFE),
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
