import 'dart:ui';

import 'package:family_member/constant/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onInitializationComplete;
  const SplashScreen({required Key key, required this.onInitializationComplete})
      : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
        backgroundColor: mainHomeboldTextColor,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/birds.png'),
              fit: BoxFit.cover,
            ),
          ),
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
                      image: AssetImage('assets/images/familyhome2nobg.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                  child: SizedBox(
                    height: 2,
                  ),
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
