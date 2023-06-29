import 'package:flutter/material.dart';
import 'package:first_login_test/screens/admin_screen.dart';
import 'package:first_login_test/screens/user_screen.dart';
import 'package:first_login_test/services/auth_service.dart';

class RegisterPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                var username = _usernameController.text;
                var email = _emailController.text;
                var password = _passwordController.text;
                var tokens = await register(username, email, password);
                if (tokens != null) {
                  var role = tokens['user_roles'][0]['NombreRol'];
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
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
