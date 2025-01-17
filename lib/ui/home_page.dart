import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Text("Selamat datang di home page"),
            ElevatedButton(
              onPressed: () async {
                const FlutterSecureStorage().delete(key: 'jwt_token');
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text("Logout"),
            )
          ],
        ),
      ),
    );
  }
}
