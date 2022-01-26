import 'dart:ui';

import 'package:family_member/constant/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen2 extends StatefulWidget {
  final VoidCallback onInitializationComplete;
  const SplashScreen2(
      {required Key key, required this.onInitializationComplete})
      : super(key: key);

  @override
  _SplashScreen2State createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 5))
        .then((_nothing) => widget.onInitializationComplete());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ANIM',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: SplashScreenBgColor,
        body: Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage('assets/images/birds.png'),
          //     fit: BoxFit.cover,
          //   ),
          // ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/Connecle.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                  child: SizedBox(
                    height: 2,
                  ),
                ),

                Center(
                  child: CircularProgressIndicator(
                    color: mainHomeboldTextColor,
                  ),
                )
                // Text(
                //   'ANIM',
                //   style: GoogleFonts.luckiestGuy(
                //     textStyle: TextStyle(color: mainHomeTextColor),
                //   ),
                // ),
                // Text(
                //   'ANIM',
                //   style: GoogleFonts.baumans(
                //     textStyle: TextStyle(color: mainHomeTextColor),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
