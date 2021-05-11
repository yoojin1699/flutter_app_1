import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/main_page.dart';
import 'package:flutter_application_1/util/firebase.dart';
import 'package:animations/animations.dart';

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _page = 0;
  List pages = [
    {
      'title': 'Home', //mapping 화면이 될 것임
      'page': MainPage(email: firebaseAuth.currentUser.email), // 일단 ...
      'index': 0,
    },
    {
      'title': 'Profile', //Profile
      'page':
          MainPage(email: firebaseAuth.currentUser.email), // 완성되면 바꿀것 (언니꼬😘)
      'index': 1,
    },
    {
      'title': 'Community', //Community
      'page':
          MainPage(email: firebaseAuth.currentUser.email), // 완성되면 바꿀것 (내꺼 😎)
      'index': 2,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTransitionSwitcher(
        transitionBuilder: (
          Widget child,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: pages[_page]['page'],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 5),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
            ),
            SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}
