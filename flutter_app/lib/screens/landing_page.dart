// ignore_for_file: prefer_const_constructors

import 'package:first_login_test/screens/register_page.dart';
import 'package:flutter/material.dart';
import 'package:first_login_test/screens/login_page.dart';

class LandingScreen extends StatefulWidget {
  @override
  LandingScreenState createState() => LandingScreenState();
}

class LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FastAPI Flutter Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Let's get started",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                // Realiza la solicitud de login y muestra el resultado en la consola.
                //login('myusername', 'mypassword');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Login'),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                // Realiza la solicitud de registro de usuario y muestra el resultado en la consola.
                //createUser('newusername', 'newemail@gmail.com', 'newpassword');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text('Create New User'),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                // Realiza la solicitud de recuperación de contraseña y muestra el resultado en la consola.
                //passwordRecovery('email@gmail.com');
              },
              child: Text('Password Recovery'),
            ),
          ],
        ),
      ),
    );
  }
}
