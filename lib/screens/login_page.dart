import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/join_or_login.dart';
import 'package:flutter_application_1/screens/main_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/screens/forgot_pw.dart';
import 'package:flutter_application_1/base_map.dart';

class AuthPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // text 받는 거 확인하는 거 emil, password 있음.
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    //실제 핸드폰의 사이즈

    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            _logoImage,
            Stack(
              children: <Widget>[
                _inputForm(size),
                _authButton(size),

                // // Start without login
                // GestureDetector(
                //   onTap: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => MainPage(email: "비회원")));
                //   },
                //   child: new Text(
                //     "비회원으로 접속하기",
                //     style: TextStyle(fontSize: 15, color: Colors.blue),
                //   ),
                // )
              ],
            ),

            SizedBox(height: 12.0),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              GestureDetector(
                onTap: () {
                  _anonLogin(context);
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => MainPage(email: )));
                },
                child: Text(
                  'Login as Guest',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 15,
                  ),
                ),
              ),
            ]),

            Container(
              height: size.height * 0.1,
            ),
            //join or login 인지 정보 받아서 , sign in or create one 결정
            Consumer<JoinOrLogin>(
              builder: (context, joinOrLogin, child) => GestureDetector(
                  onTap: () {
                    joinOrLogin.toggle();
                  },
                  child: Text(
                    joinOrLogin.isJoin
                        ? "Already Have an Account? Sign in"
                        : "Don't Have an Acoount? Create One",
                    style: TextStyle(
                        color: joinOrLogin.isJoin ? Colors.red : Colors.blue),
                  )),
            ),

            Container(
              height: size.height * 0.05,
            ),
          ],
        )
      ],
    ));
  }

// 이메일/비밀번호 등록하는 함수
  void _register(BuildContext context) async {
    final UserCredential result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
    final User user = result.user;

    if (user == null) {
      final snackBar = SnackBar(
        content: Text('Please try again later.'),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

// 로그인 하는 함수
  void _login(BuildContext context) async {
    final UserCredential result = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
    final User user = result.user;

    if (user == null) {
      final snackBar = SnackBar(
        content: Text('Please try again later.'),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

// Guest Login
  void _anonLogin(BuildContext context) async {
    final UserCredential result =
        await FirebaseAuth.instance.signInAnonymously();

    final User user = result.user;

    if (user == null) {
      final snackBar = SnackBar(
        content: Text('Please try again later.'),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

//로고 이미지 불러옴
  Widget get _logoImage => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 80, left: 0, right: 0),
          child: Container(
            //  height: 250,
            //  width: 250,
            decoration: new BoxDecoration(
              image: DecorationImage(
                //   fit: BoxFit.none,
                image: AssetImage("assets/logo.png"),
              ),
            ),
          ),
        ),
      );

// 로그인 또는 sign up 버튼임.
  Widget _authButton(Size size) => Positioned(
        left: size.width * 0.1,
        right: size.width * 0.1,
        bottom: 0,
        child: SizedBox(
          height: 50,
          child: Consumer<JoinOrLogin>(
            builder: (context, joinOrLogin, child) => RaisedButton(
                child: Text(
                  joinOrLogin.isJoin ? "Sign Up" : "Login",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                color: joinOrLogin.isJoin ? Colors.red : Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    joinOrLogin.isJoin ? _register(context) : _login(context);
                  }
                }),
          ),
        ),
      );

// 이메일/비밀번호 입력 창
  Widget _inputForm(Size size) => Padding(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 12.0, right: 12.0, top: 12.0, bottom: 32.0),
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          icon: Icon(Icons.account_circle), labelText: "Email"),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please input correct Email.";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                          icon: Icon(Icons.vpn_key), labelText: "Password"),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please input correct password.";
                        }
                        return null;
                      },
                    ),
                    Container(
                      height: 10,
                    ),
                    Consumer<JoinOrLogin>(
                      builder: (context, joinOrLogin, child) => Opacity(
                        opacity: joinOrLogin.isJoin ? 0 : 1,
                        child: GestureDetector(
                          onTap: joinOrLogin.isJoin
                              ? null
                              : () {
                                  goToForgotPw(context);
                                },
                          child: Text("Forgot password"),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      );

  goToForgotPw(BuildContext context) {
    Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BaseMapPage(),
            ));
  }
}
