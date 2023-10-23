import 'package:flutter/material.dart';

class DialogeTest extends StatefulWidget {
  const DialogeTest({super.key});

  @override
  State<DialogeTest> createState() => _DialogeTestState();
}

class _DialogeTestState extends State<DialogeTest> {
  bool isLoading = false;

  void _showDialoge() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('$isLoading'),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: FilledButton(
                onPressed: () async {
                  _showDialoge();
                  await Future.delayed(Duration(seconds: 2));
                  setState(() {
                    isLoading = true;
                  });
                },
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Show Dialoge')),
          )
        ],
      ),
    );
  }
}
