import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family_member/constant/Not_Active_member_card.dart';
import 'package:family_member/constant/member_card.dart';
import 'package:family_member/services/search_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FamilyDetails extends StatefulWidget {
  @override
  _FamilyDetailsState createState() => _FamilyDetailsState();
}

class _FamilyDetailsState extends State<FamilyDetails> {
  CollectionReference profileList =
      FirebaseFirestore.instance.collection('Users');

  List userProfileList = [];
  List searchUserList = [];

  // To search the user profile
  bool searchState = false;

  var queryResult = [];
  var tempSearchStore = [];

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResult = [];
        tempSearchStore = [];
      });
    }

    // if user enters value with uppercase
    var smallValue = value.substring(0, 1).toLowerCase() + value.substring(1);

    if (queryResult.length == 0 && value.length == 1) {
      SearchService().searchByID(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.docs.length; ++i) {
          queryResult.add(docs.docs[i].data());
        }
      });
    } else {
      tempSearchStore = [];
      queryResult.forEach((element) {
        if (element['name'].startsWith(smallValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

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
        title: !searchState
            ? Text('Family Details')
            : TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search),
                  hintText: 'Search Member',
                ),
                onChanged: (searchText) {
                  // In Bottom of this file
                  initiateSearch(searchText);
                  setState(() {
                    searchState = !searchState;
                  });
                },
              ),
        backgroundColor: Colors.pinkAccent.withOpacity(0.5),
        actions: [
          !searchState
              ? IconButton(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  onPressed: () {
                    setState(() {
                      searchState = !searchState;
                    });
                  },
                  icon: Icon(
                    Icons.search_rounded,
                    color: Colors.white,
                  ),
                )
              : IconButton(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  onPressed: () {
                    setState(() {
                      searchState = !searchState;
                    });
                  },
                  icon: Icon(
                    Icons.search_rounded,
                    color: Colors.white,
                  ),
                ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Text(
                'find your close one here ,',
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
                    height: 400,
                    child: searchState
                        ? GridView.count(
                            crossAxisCount: 2,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4,
                            primary: false,
                            shrinkWrap: true,
                            children: tempSearchStore.map((element) {
                              return buildResultCard(element);
                            }).toList(),
                          )
                        : ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: userProfileList.length,
                            itemBuilder: (context, index) {
                              bool isUserActive =
                                  userProfileList[index]['isActive'];
                              return isUserActive
                                  ? MemberCard(
                                      name: userProfileList[index]['name'],
                                      age: userProfileList[index]['age'],
                                      uniqueID: userProfileList[index]
                                          ['uniqueID'],
                                      relationShipStatus: userProfileList[index]
                                          ['relationshipStatus'],
                                      profession: userProfileList[index]
                                          ['profession'],
                                      fatherName: userProfileList[index]
                                          ['father_name'],
                                    )
                                  : NotActiveMemberCard(
                                      name: userProfileList[index]['name'],
                                      age: userProfileList[index]['age'],
                                      uniqueID: userProfileList[index]
                                          ['uniqueID'],
                                      relationShipStatus: userProfileList[index]
                                          ['relationshipStatus'],
                                      profession: userProfileList[index]
                                          ['profession'],
                                      fatherName: userProfileList[index]
                                          ['father_name'],
                                    );
                            },
                          ),
                  ),
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

  Widget buildResultCard(data) {
    return Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 2.0,
        child: Container(
            child: Center(
                child: Text(
          data['businessName'],
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
        ))));
  }
}

/**
 * ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: userProfileList.length,
                            itemBuilder: (context, index) {
                              bool isUserActive =
                                  userProfileList[index]['isActive'];
                              return isUserActive
                                  ? MemberCard(
                                      name: userProfileList[index]['name'],
                                      age: userProfileList[index]['age'],
                                      uniqueID: userProfileList[index]
                                          ['uniqueID'],
                                      relationShipStatus: userProfileList[index]
                                          ['relationshipStatus'],
                                      profession: userProfileList[index]
                                          ['profession'],
                                      fatherName: userProfileList[index]
                                          ['father_name'],
                                    )
                                  : NotActiveMemberCard(
                                      name: userProfileList[index]['name'],
                                      age: userProfileList[index]['age'],
                                      uniqueID: userProfileList[index]
                                          ['uniqueID'],
                                      relationShipStatus: userProfileList[index]
                                          ['relationshipStatus'],
                                      profession: userProfileList[index]
                                          ['profession'],
                                      fatherName: userProfileList[index]
                                          ['father_name'],
                                    );
                            },
                          ),
 */