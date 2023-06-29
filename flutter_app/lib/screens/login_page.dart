// ignore_for_file: prefer_const_constructors

import 'package:first_login_test/screens/admin_screen.dart';
import 'package:first_login_test/screens/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:first_login_test/services/auth_service.dart';

class LoginPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // void loginButtonPressed() async {
  //   String username = usernameController.text;
  //   String password = passwordController.text;
  //   userRole = await apiService.login(username, password);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                var username = usernameController.text;
                var password = passwordController.text;
                var tokens = await login(username, password);
                if (tokens != null) {
                  var role = tokens['roles'][0];
                  if (role == 'Admin') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => AdminScreen()),
                    );
                  } else if (role == 'User') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => UserScreen()),
                    );
                  }
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
