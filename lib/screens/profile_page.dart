import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/data/join_or_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/edit_profile_page.dart';
import 'package:flutter_application_1/utils/user_preferences.dart';
import 'package:flutter_application_1/widgets/appbar_widget.dart';
import 'package:flutter_application_1/widgets/numbers_widget.dart';
import 'package:flutter_application_1/widgets/profile_widget.dart';

import '../model/user.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () async {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EditProfilePage()),
              );
            },
          ),
          // username, email 표시
          const SizedBox(height: 12),
          buildName(user),
          const SizedBox(height: 8),
          // rank, follower, following 수 표시
          NumbersWidget(),
        ],
      ),
    );
  }

  Widget buildName(UserModel user) => Column(
        children: [
          Text(
            user.username,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
          ),
          // email 안 넣는 게 나을 거 같다
          // Text(
          // TODO: firebase에서 email 가져와서 표시, guest인 경우 exception handling 필요
          // user.email
          //   'email',
          //   style: TextStyle(color: Colors.grey),
          // ),
        ],
      );
}

// class MyPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text(FirebaseAuth.instance.currentUser.uid),
//       // ),
//       body: Container(
//         child: Center(
//           child: FlatButton(
//             onPressed: () {
//               FirebaseAuth.instance.signOut();
//             },
//             child: Text("Logout"),
//           ),
//         ),
//       ),
//     );
//   }
// }
