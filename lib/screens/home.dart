import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Logged in!'),
        ),
        body: Center(
          child: Text(
              'Welcome',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)
          ),
        ),
      ),
    );
  }
}