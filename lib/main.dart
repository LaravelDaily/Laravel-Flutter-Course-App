import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Container(
          color: Theme.of(context).primaryColorDark,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Card(
                    elevation: 8,
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          TextField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email',
                            ),
                          ),
                          TextField(
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(labelText: 'Password'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              print('Login attempt');
                            },
                            child: Text('Login'),
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 36)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]
            ),
          ),
        ),
      ),
    );
  }
}
