import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/fab_container.dart';

class FabcontainerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(FirebaseAuth.instance.currentUser.uid),
      // ),
      body: Container(
        child: FabContainer(),
        ),
      );
    
  }
}
