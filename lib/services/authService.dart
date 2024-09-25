import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class AuthService {
  final String apiUrl = 'http://192.168.173.52:5000/9GAG/auth';
  final storage = FlutterSecureStorage();

  Future<bool> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': name,
        'email': email,
        'password': password,
      }),
    );

    return response.statusCode == 201;
  }

  Future<Map<String, String>?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      await storage.write(key: 'token', value: jsonResponse['token']);
      await storage.write(key: 'userId', value: jsonResponse['userId']);
      return {'token': jsonResponse['token'], 'userId': jsonResponse['userId']};
    } else {
      return null; // Login failed
    }
  }

  Future<Map<String, dynamic>?> getUserData(String token) async {
    final response = await http.get(
      Uri.parse('$apiUrl/user'),
      headers: {'auth-token': token,'Content-Type': 'application/json',},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null; // Error fetching user data
    }
  }

  // Future<Map<String, dynamic>?> getUserProfile(String token) async {
  //   final response = await http.get(
  //     Uri.parse('$apiUrl/userProfile'),
  //     headers: {'auth-token': token,'Content-Type': 'application/json',},
  //   );
  //
  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   } else {
  //     return null; // Error fetching user data
  //   }
  // }

  Future<void> logout() async {
    await storage.delete(key: 'token');
  }

  Future<void> deleteUser() async {
    String? token = await storage.read(key: 'token');
    final response = await http.delete(
      Uri.parse('$apiUrl/delete'),
      headers: {
        'auth-token': token ?? '',
      },
    );

    if (response.statusCode == 200) {
      await storage.delete(key: 'token');
    }
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  Future<bool> isLoggedIn() async {
    final token = await storage.read(key: 'token');
    return token != null;
  }

  Future<bool> updateProfile(String id, String name, String email, String bod,
      String date, String gender, File file) async {
    try {
      final mimeType = lookupMimeType(file.path);
      final request = http.MultipartRequest('PUT', Uri.parse('$apiUrl/update/$id'))
        ..fields['username'] = name
        ..fields['email'] = email
        ..fields['BOD'] = bod
        ..fields['createdAt'] = date
        ..fields['gender'] = gender
        ..files.add(await http.MultipartFile.fromPath(
          'profilePhoto',
          file.path,
          contentType: MediaType.parse(mimeType!),
        ));

      final response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await http.Response.fromStream(response);
        print('Profile updated successfully: ${responseBody.body}');
        return true;
      } else {
        throw Exception('Failed to update profile');
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
  // Future<bool> updateProfile(String id, String name, String email, String Bod,
  //     String date, String gender,File file) async {
  //   final response = await http.put(
  //     Uri.parse('$apiUrl/update/$id'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //     },
  //     body: jsonEncode({
  //       'username': name,
  //       'email': email,
  //       'BOD': Bod,
  //       "createdAt": date,
  //       "gender": gender,
  //
  //       // 'profilePhoto': base64Image,
  //       // 'mimeType': mimeType,
  //     }),
  //   );
  //   return response.statusCode == 200;
  // }
}
