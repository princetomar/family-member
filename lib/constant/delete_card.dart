import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteCard extends StatefulWidget {
  late String name;
  late int age;
  late String relationShipStatus;
  late String fatherName;
  late String profession;
  late String uniqueID;
  late bool isActive;

  late int index;

  DeleteCard({
    required this.name,
    required this.age,
    required this.relationShipStatus,
    required this.fatherName,
    required this.profession,
    required this.uniqueID,
    required this.isActive,
    required this.index,
  });

  @override
  State<DeleteCard> createState() => _DeleteCardState();
}

class _DeleteCardState extends State<DeleteCard> {
  CollectionReference profileList =
      FirebaseFirestore.instance.collection('Users');

  List userProfileList = [];
  List searchUserList = [];

  // To search the user profile
  bool searchState = false;

  bool _switchValue = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserList();
  }

  // This fetches all the user's information
  fetchUserList() async {
    dynamic result = await getUserList();

    if (result == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        userProfileList = result;
      });
    }
  }

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
                  text: '${widget.name}',
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
                  text: '${widget.age.toString()}',
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
                  text: '${widget.uniqueID}',
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
                  text: '${widget.relationShipStatus}',
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
                  text: '${widget.fatherName}',
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
                  text: '${widget.profession}',
                  style: TextStyle(
                    color: Color(0xFFB7FDFE),
                  ),
                ),
              ],
            ),
          ),
          CupertinoSwitch(
              value: widget.isActive,
              onChanged: (value) {
                setState(() {
                  widget.isActive = value;
                  updateUserRecord(
                    userProfileList[widget.index][!value],
                  );
                  if (widget.isActive == true) {
                    print('Active');
                  } else {
                    print('Inactive');
                  }
                });
              }),
        ],
      ),
    );
  }

  Future getUserList() async {
    List userList = [];

    try {
      await profileList.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          userList.add(element.data());
        });
      });
      return userList;
    } catch (e) {
      print(e.toString());
    }
  }

  Future? updateUserRecord(
    bool isActive,
  ) async {
    final User user = await FirebaseAuth.instance.currentUser!;
    return await profileList.doc(user.uid).update({
      'isActive': !isActive,
    });
  }
}
