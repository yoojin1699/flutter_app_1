import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/data/join_or_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(FirebaseAuth.instance.currentUser.uid),
      // ),
      body: Container(
        child: Center(
          child: FlatButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            child: Text("Logout"),
          ),
        ),
      ),
    );
  }
}
