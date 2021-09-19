import 'package:flutter/material.dart';
import 'package:my_first_app/providers/CategoryProvider.dart';
import 'package:my_first_app/screens/categories.dart';
import 'package:my_first_app/screens/login.dart';
import 'package:my_first_app/screens/register.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<CategoryProvider>(
              create: (context) => CategoryProvider()),
        ],
        child: MaterialApp(title: 'Welcome to Flutter', home: Login(), routes: {
          '/login': (context) => Login(),
          '/register': (context) => Register(),
          '/categories': (context) => Categories(),
        }));
  }
}
