import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family_member/constant/Not_Active_member_card.dart';
import 'package:family_member/constant/delete_card.dart';
import 'package:family_member/constant/member_card.dart';
import 'package:family_member/services/data_controller.dart';
import 'package:family_member/services/search_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArchiveMember extends StatefulWidget {
  @override
  _ArchiveMemberState createState() => _ArchiveMemberState();
}

class _ArchiveMemberState extends State<ArchiveMember> {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  FirebaseAuth _auth = FirebaseAuth.instance;

  List userProfileList = [];
  List searchUserList = [];

  // To search the user profile
  bool searchState = false;

  bool _switchValue = true;
  final TextEditingController searchController = TextEditingController();
  late QuerySnapshot snapshotData;
  bool isExecuted = false;

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
        actions: [
          GetBuilder<DataConroller>(
              init: DataConroller(),
              builder: (val) {
                return IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.search),
                  onPressed: () {
                    getSearchUserList(searchController.text);
                    setState(() {
                      isExecuted = true;
                      searchState = true;
                    });
                    // val.queryData(searchController.text).then((value) {
                    //   snapshotData = value;
                    //   setState(() {
                    //     isExecuted = true;
                    //   });
                    // });
                  },
                );
              })
        ],
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search unique ID',
            hintStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        backgroundColor: Color(0xFF15B097),
      ),
      body: SingleChildScrollView(
        child: isExecuted
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: searchUserList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // FirebaseFirestore.instance
                      //     .collection('Users')
                      //     .doc(searchUserList[index]['uniqueId'])
                      //     .update({
                      //   'name': searchUserList[index]['name'],
                      //   'age': searchUserList[index]['age'],
                      //   'father_name': searchUserList[index]['father_name'],
                      //   'profession': searchUserList[index]['profession'],
                      //   'uniqueID': searchUserList[index]['uniqueID'],
                      //   'relationshipStatus': searchUserList[index]
                      //       ['relationshipStatus'],
                      //   'isActive': false,
                      // });
                      
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                  'Are you sure you want to Archive this member ?'),
                              actions: [
                                FlatButton(
                                  child: Text('Yes'),
                                  onPressed: () async {


                                    FirebaseFirestore.instance
                                        .collection('Users')
                                        .doc()
                                        .update({
                                      'isActive': false,
                                      'name': searchUserList[index]['name'],
                                      'age': searchUserList[index]['age'],
                                      'father_name': searchUserList[index]
                                          ['father_name'],
                                      'profession': searchUserList[index]
                                          ['profession'],
                                      'uniqueID': searchUserList[index]
                                          ['uniqueID'],
                                      'relationshipStatus':
                                          searchUserList[index]
                                              ['relationshipStatus'],
                                    }).whenComplete(
                                            () => Navigator.pop(context));
                                  },
                                ),
                                FlatButton(
                                  child: Text('No'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            );
                          });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 17, vertical: 2),
                      child: MemberCard(
                        name: searchUserList[index]['name'],
                        age: searchUserList[index]['age'],
                        relationShipStatus: searchUserList[index]
                            ['relationshipStatus'],
                        fatherName: searchUserList[index]['father_name'],
                        profession: searchUserList[index]['profession'],
                        uniqueID: searchUserList[index]['uniqueID'],
                      ),
                    ),
                  );
                })
            : Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    Text(
                      'Discard Member ,',
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
                                ? Text(
                                    'Tap on the search bar again to et the result',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 30),
                                  )
                                : StreamBuilder(
                                    stream: users.snapshots(),
                                    builder: (_,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasData) {
                                        return ListView.builder(
                                            itemCount:
                                                snapshot.data?.docs.length,
                                            itemBuilder: (context, index) {
                                              bool isUserActive =
                                                  userProfileList[index]
                                                      ['isActive'];
                                              return isUserActive
                                                  ? InkWell(
                                                      child: MemberCard(
                                                        name: userProfileList[
                                                            index]['name'],
                                                        age: userProfileList[
                                                            index]['age'],
                                                        relationShipStatus:
                                                            userProfileList[
                                                                    index][
                                                                'relationshipStatus'],
                                                        fatherName:
                                                            userProfileList[
                                                                    index]
                                                                ['father_name'],
                                                        profession:
                                                            userProfileList[
                                                                    index]
                                                                ['profession'],
                                                        uniqueID:
                                                            userProfileList[
                                                                    index]
                                                                ['uniqueID'],
                                                      ),
                                                      onTap: () {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return AlertDialog(
                                                                title: Text(
                                                                    'Are you sure you want to Archive this member ?'),
                                                                actions: [
                                                                  FlatButton(
                                                                    child: Text(
                                                                        'Yes'),
                                                                    onPressed:
                                                                        () async {
                                                                      snapshot
                                                                          .data!
                                                                          .docs[
                                                                              index]
                                                                          .reference
                                                                          .update({
                                                                        'isActive':
                                                                            false,
                                                                      }).whenComplete(() =>
                                                                              Navigator.pop(context));
                                                                    },
                                                                  ),
                                                                  FlatButton(
                                                                    child: Text(
                                                                        'No'),
                                                                    onPressed:
                                                                        () {
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
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.02,
                                                    );
                                            });
                                      } else {
                                        return Text(
                                          'Tap on the search bar again to et the result',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 30),
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

  getSearchUserList(String query) {
    return FirebaseFirestore.instance
        .collection('Users')
        .where('uniqueID', isEqualTo: query)
        .get()
        .then((value) => searchUserList.add(value.docs[0].data()));
  }
}

/**
 *  Widget searchData() {
      return Expanded(
        child: SizedBox(
          height: 500,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: snapshotData.docs.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: MemberCard(
                  name: snapshotData.docs[index]['name'],
                  age: snapshotData.docs[index]['age'],
                  relationShipStatus: snapshotData.docs[index]
                      ['relationshipStatus'],
                  fatherName: snapshotData.docs[index]['father_name'],
                  profession: snapshotData.docs[index]['profession'],
                  uniqueID: snapshotData.docs[index]['uniqueID'],
                ),
              );
            },
          ),
        ),
      );
    }

 */