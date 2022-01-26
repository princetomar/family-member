import 'package:flutter/material.dart';

import 'color_constants.dart';

class Custom_button extends StatelessWidget {
  String text;
  double width;
  Icon icon;
  late Function onPressed;

  Custom_button(
      {required this.width,
      required this.text,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
                  onPressed: () {
                    onPressed();
                  
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primarycolor, secondarycolor],
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    width: width * 0.6,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [Text('$text'), Icon(Icons.person_add)],
                    ),
                  ));
  }
}
