import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoplink_test/config/api.dart';
import 'package:http/http.dart' as http;
import 'package:shoplink_test/models/pref.dart';
import 'package:shoplink_test/pages/main.pages.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

enum LoginStatus { isSignIn, isNotSignIn }

class _LoginState extends State<Login> {
  LoginStatus loginStatus = LoginStatus.isSignIn;
  var loading = false;

  savePref(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString(PrefModel.token, token);
    });
  }

  handleLogin() async {
    setState(() {
      loading = true;
    });
    final response = await http
        .post(BaseUrl.apiLogin, body: {"id": "user", "password": "1234"});

    final data = jsonDecode(response.body);
    var message = data['success'];
    var token = data['jwt'];

    if (message == true) {
      setState(() {
        loading = false;
        savePref(token);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MainPage()));
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: loading
              ? CircularProgressIndicator()
              : RaisedButton(
                  onPressed: () {
                    handleLogin();
                  },
                  child: Text("Login"),
                ),
        ),
      ),
    );
  }
}
