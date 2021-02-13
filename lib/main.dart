import 'package:indus_task/screen/login_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(new App());

class App extends StatelessWidget {
  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("LogIn"),
        ),
        body: LoginScreen(),
      ),
    );
  }
}
