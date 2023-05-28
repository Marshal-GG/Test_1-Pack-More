import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';

class MyData {
  late final String name;
  late final int age;

  MyData({required this.name, required this.age});
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 45),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Welcome!",
                  // style: GoogleFonts.alata(
                  //   fontWeight: FontWeight.w900,
                  //   fontSize: 40,
                  // ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AppBar(
      elevation: 0,
      backgroundColor: colorScheme.primary,
      actions: [
        Padding(
          padding: EdgeInsets.all(12),
          child: SizedBox(
            width: 33,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(100),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  size: 18,
                ),
                onPressed: () {},
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: SizedBox(
            width: 33,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(100),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.sunny,
                  size: 18,
                ),
                onPressed: () {},
              ),
            ),
          ),
        ),
        SizedBox(width: 8)
      ],
      title: Text("Home", style: TextStyle(color: colorScheme.onPrimary)),
      centerTitle: false,
    );
  }
}
