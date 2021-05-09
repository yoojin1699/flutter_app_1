import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  // 메인 페이지  : 인자 email
  MainPage({this.email});

  final String email ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(email),
      ),
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
