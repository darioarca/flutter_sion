import 'package:flutter/material.dart';
import 'package:first_login_test/services/auth_service.dart';

class ChangePassScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final TextEditingController oldPassController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();

  // void loginButtonPressed() async {
  //   String username = usernameController.text;
  //   String password = passwordController.text;
  //   userRole = await apiService.login(username, password);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: oldPassController,
              decoration: InputDecoration(labelText: 'Old Password'),
            ),
            TextFormField(
              controller: newPassController,
              decoration: InputDecoration(labelText: 'New Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                var oldPassword = oldPassController.text;
                var newPassword = newPassController.text;
                if (await changePassword(oldPassword, newPassword)) {
                  print('Your password has been changed correctly.');
                  Navigator.pop(context);
                }
              },
              child: Text('Change Password'),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
