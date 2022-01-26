import 'package:family_member/services/storage_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

class AddMember extends StatefulWidget {
  @override
  _AddMemberState createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  final FirebaseStorage _storage = FirebaseStorage.instance;
  late double _deviceHeight;
  late double _deviceWidth;
  TextEditingController _name = TextEditingController();
  TextEditingController _age = TextEditingController();
  TextEditingController _relationshipStatus = TextEditingController();
  TextEditingController _profession = TextEditingController();
  TextEditingController _father_name = TextEditingController();

  bool switchValue = true;

  // To give auto-ID to user
  CollectionReference profileList =
      FirebaseFirestore.instance.collection('Users');

  List userProfileList = [];

  // To pick files from the device
  final Storage storage = Storage();

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

  @override
  Widget build(BuildContext context) {
    // To pick files from the device
    //final fileName = file != null ? basseName(file!.path) : 'No File Selected';

    // To set the height and width of the device
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxScrolled) => [
          SliverAppBar(
            backgroundColor: Colors.tealAccent,
            floating: true,
            title: Text(
              'Connecle',
              style: TextStyle(color: Color(0xFF000000)),
            ),
            toolbarHeight: _deviceHeight * 0.07,
          ),
        ],
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Text(
                    'Register your family member here,',
                    style: TextStyle(fontSize: _deviceHeight * 0.04),
                  ),
                  SizedBox(
                    height: _deviceHeight * 0.01,
                  ),
                  Text(
                    'We will help you to connect with your family members',
                    style: TextStyle(
                        fontSize: _deviceHeight * 0.03, color: Colors.grey),
                  ),
                  // SizedBox(
                  //   height: _deviceHeight * 0.01,
                  // ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFF5438DC),
                      border: Border.all(),
                    ),
                    child: IconButton(
                        onPressed: () async {
                          final result = await FilePicker.platform.pickFiles(
                            allowMultiple: false,
                            type: FileType.custom,
                            allowedExtensions: ['png', 'jpg', 'jpeg'],
                          );

                          if (result == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('No file Selected !')));

                            return null;
                          }

                          final path = result.files.single.path!;
                          final filename = result.files.single.name;

                          storage
                              .uploadFile(path, filename)
                              .then((value) => print('Done'));

                          print(path);
                          print(filename);
                        },
                        icon: Icon(
                          Icons.person_pin_rounded,
                          color: Color(0xFF56EEF4),
                          size: _deviceHeight * 0.055,
                          // size: _deviceHeight * 0.1,
                        )),
                  ),
                  SizedBox(
                    height: _deviceHeight * 0.02,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: _deviceWidth * 0.03,
                        vertical: _deviceHeight * 0.01),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(),
                    ),
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Name',
                          ),
                          controller: _name,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Age',
                          ),
                          keyboardType: TextInputType.number,
                          controller: _age,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Relationship Status',
                          ),
                          controller: _relationshipStatus,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Profession',
                          ),
                          controller: _profession,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Father's Name",
                          ),
                          controller: _father_name,
                        ),
                        SizedBox(
                          height: _deviceHeight * 0.04,
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(
                          Size(
                            _deviceWidth * 0.4,
                            _deviceHeight * 0.06,
                          ),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          Color(0xFF5438DC),
                        ),
                      ),
                      onPressed: () {
                        _addUserToFirebase();
                        setState(() {
                          _name.clear();
                          _age.clear();
                          _relationshipStatus.clear();
                          _profession.clear();
                          _father_name.clear();
                        });
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                title: Text(
                                    'User added Succesfully !\nPress OK to continue'),
                                actions: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.tealAccent,
                                    ),
                                    child: FlatButton(
                                      child: Text('ok'),
                                      onPressed: () async {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                      child: Row(
                        children: [
                          Text(
                            'Add Member',
                            style: TextStyle(
                              color: Color(0xFF56EEF4),
                            ),
                          ),
                          Icon(
                            Icons.add,
                            color: Color(0xFF56EEF4),
                          ),
                        ],
                      ))
                ],
              )),
        ),
      ),
    );
  }

  _addUserToFirebase() async {
    int MemberAge = int.parse(_age.text);
    await users.add({
      'name': _name.text.toUpperCase(),
      'age': MemberAge,
      'relationshipStatus': _relationshipStatus.text.toUpperCase(),
      'profession': _profession.text,
      'father_name': _father_name.text,
      'uniqueID': '000${userProfileList.length + 1}',
      'isActive': switchValue,
      'searchKey': _name.text.substring(1),
    }).then((value) => print('User Added ! '));
  }

  // Future selectFile() async {
  //   final _result = await FilePicker.platform.pickFiles(
  //     allowMultiple: false,
  //   );
  //   if (_result == null) return;

  //   final _path = _result.files.single.path!;
  //   setState(() {
  //     file = File(path);
  //   });
  // }

}
