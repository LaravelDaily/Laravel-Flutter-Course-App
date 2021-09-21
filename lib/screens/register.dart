import 'package:flutter/material.dart';
import 'package:my_first_app/providers/AuthProvider.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  Register();

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  String errorMessage = '';

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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            keyboardType: TextInputType.name,
                            controller: nameController,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Enter name';
                              }

                              return null;
                            },
                            onChanged: (text) => setState(() => errorMessage = ''),
                            decoration: InputDecoration(
                              labelText: 'Name',
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Enter email';
                              }

                              return null;
                            },
                            onChanged: (text) => setState(() => errorMessage = ''),
                            decoration: InputDecoration(
                              labelText: 'Email',
                            ),
                          ),
                          TextFormField(
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            controller: passwordController,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Enter password';
                              }

                              return null;
                            },
                            onChanged: (text) => setState(() => errorMessage = ''),
                            decoration: InputDecoration(labelText: 'Password'),
                          ),
                          TextFormField(
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            controller: passwordConfirmController,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Repeat password';
                              }

                              return null;
                            },
                            onChanged: (text) => setState(() => errorMessage = ''),
                            decoration:
                                InputDecoration(labelText: 'Confirm Password'),
                          ),
                          ElevatedButton(
                            onPressed: () => submit(),
                            child: Text('Register'),
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 36)),
                          ),
                          Text(errorMessage, style: TextStyle(color: Colors.red)),
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
                ),
              ]),
        ),
      ),
    );
  }

  Future<void> submit() async {
    final form = _formKey.currentState;

    if (!form!.validate()) {
      return;
    }

    final AuthProvider provider = Provider.of<AuthProvider>(context, listen: false);
    try {
      String token = await provider.register(
          nameController.text,
          emailController.text,
          passwordController.text,
          passwordConfirmController.text,
          'Some device name'
      );

      Navigator.pop(context);
    } catch (Exception) {
      setState(() {
        errorMessage = Exception.toString().replaceAll('Exception: ', '');
      });
    }
  }
}
