// rank, following, follower 수 표시하는 위젯

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NumbersWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // TODO: firebase의 database 이용하여 value 수정 필요 (두번째 field)
            buildButton(context, '1234', 'Ranking'),
            buildDivider(),
            buildButton(context, '1234', 'Following'),
            buildDivider(),
            buildButton(context, '1234', 'Followers'),
          ],
        ),
      );

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            SizedBox(height: 2),
            Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      );

  Widget buildDivider() => Container(
      height: 24,
      child: VerticalDivider(
        color: Colors.black,
      ));
}
