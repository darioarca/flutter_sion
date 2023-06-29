import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<Map<String, dynamic>?> getUserData() async {
  final storage = FlutterSecureStorage();
  String? accessToken = await storage.read(key: 'access_token');

  final response = await http.get(
    Uri.parse('http://localhost:8000/me'),
    headers: {
      'Authorization': 'Bearer $accessToken',
    },
  );

  if (response.statusCode == 200) {
    var userData = jsonDecode(response.body);
    return userData;
  } else if (response.statusCode == 401) {
    var tokens = await refreshAccessToken();
    if (tokens != null) {
      return getUserData();
    } else {
      return null;
    }
  } else {
    throw Exception('Failed to load user data');
  }
}

Future<Map<String, dynamic>?> login(String username, String password) async {
  var response = await http.post(
    Uri.parse('http://localhost:8000/token'),
    body: {'username': username, 'password': password},
  );

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    final storage = FlutterSecureStorage();
    await storage.write(
        key: 'access_token', value: jsonResponse['access_token']);
    await storage.write(
        key: 'refresh_token', value: jsonResponse['refresh_token']);
    return jsonResponse;
  } else {
    return null;
  }
}

Future<Map<String, dynamic>?> refreshAccessToken() async {
  final storage = FlutterSecureStorage();
  String? refreshToken = await storage.read(key: 'refresh_token');

  final response = await http.post(
    Uri.parse('http://localhost:8000/refresh_token'),
    body: {'refresh_token': refreshToken},
  );

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    await storage.write(
        key: 'access_token', value: jsonResponse['access_token']);
    await storage.write(
        key: 'refresh_token', value: jsonResponse['refresh_token']);
    return jsonResponse;
  } else {
    storage.deleteAll();
    return null;
  }
}

Future<Map<String, dynamic>?> register(
    String username, String email, String password) async {
  var response = await http.post(
    Uri.parse('http://localhost:8000/users'),
    body: jsonEncode({
      'NombreUsuario': username,
      'CorreoElectronico': email,
      'Contrasena': password,
    }),
    headers: {
      'Content-Type': 'application/json',
    },
  );
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    final storage = FlutterSecureStorage();
    await storage.write(
        key: 'access_token', value: jsonResponse['access_token']);
    await storage.write(
        key: 'refresh_token', value: jsonResponse['refresh_token']);
    await storage.write(
        key: 'role', value: jsonResponse['user_roles'][0]['NombreRol']);
    return jsonResponse;
  } else {
    return null;
  }
}
