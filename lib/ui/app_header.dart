import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {

  bool isMainPage;

  AppHeader({@required this.isMainPage});

  @override
  Widget build(BuildContext context) {
      return Row(
        children: <Widget>[
          Icon(
            this.isMainPage?Icons.menu:Icons.arrow_back,
            color: Colors.grey,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Gesco',
            style: TextStyle(
                fontFamily: 'BlackOpsOne',
                fontSize: 48.0,
                color: Colors.red.shade900,
                fontWeight: FontWeight.w600),
          ),
        ],
      );
  }


}
