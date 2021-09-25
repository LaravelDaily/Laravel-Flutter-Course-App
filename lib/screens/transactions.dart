import 'package:flutter/material.dart';

class Transactions extends StatefulWidget {
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Transactions'),
        ),
        body: Center(
          child: Text(
              'Coming soon',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)
          ),
        ),
      ),
    );
  }

}