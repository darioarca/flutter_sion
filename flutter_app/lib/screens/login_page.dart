// ignore_for_file: prefer_const_constructors

import 'package:first_login_test/screens/admin_screen.dart';
import 'package:first_login_test/screens/user_screen.dart';
import 'package:first_login_test/screens/register_page.dart';
import 'package:flutter/material.dart';
import 'package:first_login_test/services/auth_service.dart';
import 'package:flutter/gestures.dart';

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
                  'Welcome,\nPlease Login First',
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
                SizedBox(height: 16),
                Container(
                    alignment: Alignment.centerRight,
                    child: RichText(
                      text: TextSpan(
                          text: 'Password Recovery',
                          style:
                              TextStyle(color: Colors.blueText, fontSize: 12),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
                            }),
                    )),
                SizedBox(height: 16),
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
                          MaterialPageRoute(
                              builder: (context) => AdminScreen()),
                        );
                      } else if (role == 'User') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => UserScreen()),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.purple, // Set the button background color
                    foregroundColor: Colors.white, // Set the text color
                    minimumSize: Size(double.infinity,
                        48), // Set the button width to match the page width
                  ),
                  child: Text('Login'),
                ),
                SizedBox(height: 16),
                Container(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(
                              color: Colors.blueText,
                            ),
                          ),
                          TextSpan(
                              text: 'Register here',
                              style: TextStyle(
                                color: Colors.blueText,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegisterPage()),
                                  );
                                }),
                        ],
                      ),
                    )),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserScreen()),
                      );
                    },
                    child: Text('Temporary USER page')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AdminScreen()),
                      );
                    },
                    child: Text('Temporary ADMIN page')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
