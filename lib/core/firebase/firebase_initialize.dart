import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'firebase_options.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'services/firebase_services.dart';

Future<void> initializeApp() async {
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    GetIt.instance.registerSingleton<FirebaseService>(FirebaseService());
    // await FirebaseAppCheck.instance.activate();
  } catch (e) {
    Fluttertoast.showToast(
      msg: 'Failed to initialize Firebase: $e',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }
}
