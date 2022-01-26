import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family_member/constant/Not_Active_member_card.dart';
import 'package:family_member/constant/delete_card.dart';
import 'package:family_member/constant/member_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DeleteMember extends StatefulWidget {
  @override
  _DeleteMemberState createState() => _DeleteMemberState();
}

class _DeleteMemberState extends State<DeleteMember> {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Member'),
        backgroundColor: Color(0xFF15B097),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Text(
                'Delete Member ,',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Expanded(
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: searchState
                          ? ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: searchUserList.length,
                              itemBuilder: (context, index) {
                                return MemberCard(
                                  name: searchUserList[index]['name'],
                                  age: searchUserList[index]['age'],
                                  relationShipStatus: searchUserList[index]
                                      ['relationshipStatus'],
                                  fatherName: searchUserList[index]
                                      ['father_name'],
                                  profession: searchUserList[index]
                                      ['profession'],
                                  uniqueID: searchUserList[index]['uniqueID'],
                                );
                              },
                            )
                          : StreamBuilder(
                              stream: users.snapshots(),
                              builder:
                                  (_, AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                      itemCount: snapshot.data?.docs.length,
                                      itemBuilder: (context, index) {
                                        bool isUserActive =
                                            userProfileList[index]['isActive'];
                                        return isUserActive
                                            ? InkWell(
                                                child: MemberCard(
                                                  name: userProfileList[index]
                                                      ['name'],
                                                  age: userProfileList[index]
                                                      ['age'],
                                                  relationShipStatus:
                                                      userProfileList[index][
                                                          'relationshipStatus'],
                                                  fatherName:
                                                      userProfileList[index]
                                                          ['father_name'],
                                                  profession:
                                                      userProfileList[index]
                                                          ['profession'],
                                                  uniqueID:
                                                      userProfileList[index]
                                                          ['uniqueID'],
                                                ),
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                              'Are you sure you want to delete this member ?'),
                                                          actions: [
                                                            FlatButton(
                                                              child:
                                                                  Text('Yes'),
                                                              onPressed:
                                                                  () async {
                                                                snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                    .reference
                                                                    .delete();
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            ),
                                                            FlatButton(
                                                              child: Text('No'),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            )
                                                          ],
                                                        );
                                                      });
                                                },
                                              )
                                            : SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02,
                                              );
                                      });
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getUserList() async {
    List userList = [];

    try {
      await users.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          userList.add(element.data());
        });
      });
      return userList;
    } catch (e) {
      print(e.toString());
    }
  }
}
