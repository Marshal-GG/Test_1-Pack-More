import 'package:flutter/material.dart';

class DotDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 3.0,
      width: 3.0,
      decoration: BoxDecoration(
        color: colorScheme.onSurface,
        shape: BoxShape.circle,
      ),
    );
  }
}
