import 'package:flutter/material.dart';
import 'package:test_1/core/firebase_services.dart';
import 'package:test_1/pages/home/home.dart';

class AuthTemp extends StatelessWidget {
  const AuthTemp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await FirebaseService().signInWithGoogle();
            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
          child: Text('Login'),
        ),
      ),
    );
  }
}
