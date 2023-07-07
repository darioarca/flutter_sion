// ignore_for_file: prefer_const_constructors

import 'package:first_login_test/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:first_login_test/screens/admin_screen.dart';
import 'package:first_login_test/screens/user_screen.dart';
import 'package:first_login_test/services/auth_service.dart';
import 'package:flutter/gestures.dart';

class RegisterPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Register'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.network(
                    'https://coworkingspain.es/sites/default/files/coworking/sala-de-espera-copia-scaled.jpg',
                  ),
                  SizedBox(height: 50),
                  Text(
                    'Welcome,\nRegister to Access',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueText,
                    ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(
                        color: Colors.blueText,
                      ),
                      hintText: 'Enter your username',
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: Colors.blueText,
                      ),
                      hintText: 'Enter your email',
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: Colors.blueText,
                      ),
                      hintText: 'Enter your password',
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(
                        color: Colors.blueText,
                      ),
                      hintText: 'Confirm your password',
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      var username = usernameController.text;
                      var email = emailController.text;
                      var password = passwordController.text;
                      var confPassword = confirmPasswordController.text;
                      var tokens = await register(
                          username, email, password, confPassword);
                      if (tokens != null) {
                        var role = tokens['user_roles'][0]['NombreRol'];
                        if (role == 'Admin') {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminScreen()),
                          );
                        } else if (role == 'User') {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserScreen()),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                      onPrimary: Colors.white,
                      minimumSize: Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text('Register'),
                  ),
                  SizedBox(height: 16),
                  Container(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: "Already have an account? ",
                              style: TextStyle(
                                color: Colors.blueText,
                              ),
                            ),
                            TextSpan(
                                text: 'Login here',
                                style: TextStyle(
                                  color: Colors.blueText,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()),
                                    );
                                  }),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}
