import '../constant/config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  // For Google Sign In Button
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(bottom: 80),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF00F59D).withOpacity(0.15),
                      blurRadius: 30,
                      offset: Offset(10, 10),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                  ),
                  height: 120,
                  width: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image(
                      image: AssetImage('assets/images/Connecle.png'),
                    ),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  "Connecle",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 10),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(
                      color: secondarycolor.withOpacity(0.6),
                      fontSize: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: secondarycolor,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 5),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(
                      color: secondarycolor.withOpacity(0.6),
                      fontSize: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: secondarycolor,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),

              // Login Button
              InkWell(
                onTap: () {
                  _SignIn();
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primarycolor, secondarycolor],
                    ),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  width: MediaQuery.of(context).size.width / 3,
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                  alignment: Alignment.center,
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),

              // Signup Button
              FlatButton(
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => RegistrationScreen()));
                },
                child: Text(
                  "Don't have an account? Signup",
                  style: TextStyle(
                    color: secondarycolor,
                    fontSize: 20,
                  ),
                ),
              ),

              // Google Button and phone Button

              Container(
                margin: EdgeInsets.only(top: 10),
                child: Wrap(
                  children: [
                    FlatButton.icon(
                      onPressed: () {
                        _signInUsingGoogle();
                      },
                      icon: Icon(
                        FontAwesomeIcons.google,
                        color: Colors.redAccent,
                      ),
                      label: Text(
                        "Sign-In with Google",
                        style: TextStyle(color: Colors.redAccent, fontSize: 18),
                      ),
                    ),
                    FlatButton.icon(
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => PhoneSignIn()));
                      },
                      icon: Icon(
                        Icons.phone,
                        color: Colors.blueAccent,
                      ),
                      label: Text(
                        "Sign-In with phone",
                        style:
                            TextStyle(color: Colors.blueAccent, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _SignIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text("Success"),
                content: Text("Sign-In Successful"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Ok"),
                    onPressed: () {
                      _emailController.clear();
                      _passwordController.clear();
                      Navigator.of(ctx).pop();
                    },
                  )
                ],
              );
            });
      }).catchError((e) {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text("Error"),
                content: Text("$e"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Ok"),
                    onPressed: () {
                      _emailController.clear();
                      _passwordController.clear();
                      Navigator.of(ctx).pop();
                    },
                  )
                ],
              );
            });
      });
    } else {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Please enter email and password"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    _emailController.clear();
                    _passwordController.clear();
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            );
          });
    }
  }

  void _signInUsingGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final UserCredential userresult =
          (await _auth.signInWithCredential(credential));
      User? user = userresult.user;

      // show a dialog box with the user's name
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text("Sign In Success with Google !"),
              content: Text("${user?.displayName}"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    _emailController.clear();
                    _passwordController.clear();
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            );
          });
    } catch (e) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("$e.message"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    _emailController.clear();
                    _passwordController.clear();
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            );
          });
    }
  }
}
