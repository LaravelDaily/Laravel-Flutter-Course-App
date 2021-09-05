import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
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
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: 'Name',
                          ),
                        ),
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
                        TextField(
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(labelText: 'Confirm Password'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            print('Register attempt');
                          },
                          child: Text('Register'),
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 36)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text('<- Back to Login',
                                style: TextStyle(fontSize: 14)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
