import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_1/core/routes/router.dart';
import 'package:test_1/core/routes/my_nav_observer.dart';
import 'package:test_1/pages/auth_temp.dart';
import 'core/firebase_initialize.dart';
import 'models/getx/theme_getx_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, child) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return SafeArea(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeModel.lightTheme,
            darkTheme: ThemeModel.darkTheme,
            themeMode: themeProvider.themeMode,
            home: const AuthTemp(),
            initialRoute: '/admin-console-page',
            onGenerateRoute: generateRoute,
            navigatorObservers: [MyNavigatorObserver()],
          ),
        );
      },
    );
  }
}
