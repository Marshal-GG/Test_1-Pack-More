import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/routes/routes.dart';
import 'core/routes/my_nav_observer.dart';
import 'core/firebase/firebase_initialize.dart';
import 'core/models/drawer_selection_model.dart';
import 'core/models/theme_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => DrawerSelectionState()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return SafeArea(
        top: false,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Test 1 (Pack More)',
          theme: ThemeModel.lightTheme,
          darkTheme: ThemeModel.darkTheme,
          themeMode: themeProvider.themeMode,
          initialRoute: '/',
          onGenerateRoute: generateRoute,
          navigatorObservers: [MyNavigatorObserver()],
        ),
      );
    });
  }
}
