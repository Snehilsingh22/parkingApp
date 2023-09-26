import 'package:flutter/material.dart';

class AmmountScreen extends StatelessWidget {
  final String tappedValue;

  AmmountScreen({required this.tappedValue});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Page'),
      ),
      body: Center(
        child: Text('Tapped Value: $tappedValue'),
      ),
    );
  }
}
