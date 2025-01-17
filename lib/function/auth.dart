// auth.dart

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:todo_app/ui/home_page.dart';
import 'package:todo_app/widget/config.dart';

Future<void> login(BuildContext context, String email, String password) async {
  const storage = FlutterSecureStorage();

  try {
    final response = await http.post(
      Uri.parse('$apiBaseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      // Memeriksa apakah respons adalah JSON dan mengandung access_token
      final responseData = jsonDecode(response.body);
      if (responseData['access_token'] != null) {
        final token = responseData['access_token'];

        // Simpan token ke secure storage
        await storage.write(key: 'jwt_token', value: token);

        // Navigasi ke halaman Home setelah login berhasil
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to get token from response.')),
        );
      }
    } else {
      // Tangani kesalahan jika status bukan 200
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Login failed: ${response.statusCode}, ${response.body}'),
        ),
      );
    }
  } catch (e) {
    print('Error: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Network error: $e')),
    );
  }
}
