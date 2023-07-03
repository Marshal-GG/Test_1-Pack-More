import 'package:flutter/material.dart';
import 'package:test_1/core/firebase/firebase_services.dart';

class AuthTemp extends StatelessWidget {
  const AuthTemp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            FirebaseService().signInWithGoogle();
            Navigator.pushNamed(context, '/home-page');
            // ignore: use_build_context_synchronously
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => HomePage(),
            //   ),
            // );
          },
          child: Text('Login'),
        ),
      ),
    );
  }
}
