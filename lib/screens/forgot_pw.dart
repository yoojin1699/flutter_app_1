import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPw extends StatefulWidget {
  @override
  _ForgotPwState createState() => _ForgotPwState();
}

class _ForgotPwState extends State<ForgotPw> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
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
            FlatButton(
                onPressed: () async {
                  await FirebaseAuth.instance
                      .sendPasswordResetEmail(email: _emailController.text);
                  final snackBar = SnackBar(
                    content: Text('Check your email for password reset'),
                  );
                  Scaffold.of(_formKey.currentContext).showSnackBar(snackBar);
                },
                child: Text('Reset Password'))
          ],
        ),
      ),
    );
  }
}
