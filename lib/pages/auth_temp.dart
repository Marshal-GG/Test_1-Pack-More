import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_1/core/firebase/services/firebase_services.dart';
import 'package:test_1/core/routes/routes_config.dart';

class AuthTemp extends StatelessWidget {
  const AuthTemp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () async {
                try {
                  await FirebaseService().signInWithGoogle();

                  // ignore: use_build_context_synchronously
                  Navigator.pushNamed(context, '/home-page');
                } catch (e) {
                  Fluttertoast.showToast(
                    msg: 'Error signing in with Google: $e',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                  );
                  print('Error signing in with Google: $e');
                }
              },
              child: Text('Login'),
            ),
            Gap(30),
            FilledButton.tonal(
              onPressed: () {
                Navigator.pushNamed(context, '/login-page');
              },
              child: Text('Login Page'),
            ),
          ],
        ),
      ),
    );
  }
}
