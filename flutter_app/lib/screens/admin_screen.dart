// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:first_login_test/services/auth_service.dart';
import 'package:first_login_test/screens/change_pass_screen.dart';

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Admin Screen'),
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            FutureBuilder(
              future: getUserData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  else {
                    var userData = snapshot.data;
                    var role = userData['user_roles'][0]['NombreRol'];
                    var roleString = role is String ? role : role.toString();
                    return Text('Hello, ${userData['NombreUsuario']}'
                        '\nRole: $roleString'
                        '\nEmail: ${userData['CorreoElectronico']}'
                        '\nLanguage: ${userData['Idioma']}'
                        '\nCreation Date: ${userData['FechaCreacion']}'
                        '\nLoyalty Points: ${userData['PuntosLealtad']}');
                  }
                }
              },
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChangePassScreen()),
                  );
                },
                child: Text('Change Password')),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (await logout()) {
                    print('Successfully logged out');
                    Navigator.pop(context);
                  }
                },
                child: Text('Logout')),
          ]),
        ));
  }
}
