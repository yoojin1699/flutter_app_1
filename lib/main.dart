import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/join_or_login.dart';
import 'package:flutter_application_1/screens/login.dart';
import 'package:flutter_application_1/screens/main_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Splash(),
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return ChangeNotifierProvider<JoinOrLogin>.value(
                //로그인 정보 주는 프로바이더
                // 로그인 되어 있지 않으므로 value 값 가지고 AuthPage 로 감.
                value: JoinOrLogin(),
                child: AuthPage());
          } else {
            // 이미 로그인 되어 있으면 메인페이지로 email 넘김
            return MainPage(email: snapshot.data.email);
          }
        });
  }
}
