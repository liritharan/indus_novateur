import 'package:indus_task/screen/character_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flushbar/flushbar.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  var _isLoading = false;
  final formKey = GlobalKey<FormState>();
  String username;
  String password;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(20.0),
      child: formWidget(),
    );
  }

  Widget formWidget() {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          emailField(),
          passwordField(),
          Container(margin: EdgeInsets.only(top: 25.0)),
          submitButton()
        ],
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 3.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2.0),
        ),
        hintText: 'Username',
      ),
      onChanged: (data) {
        username = data;
      },
    );
  }

  Widget passwordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 3.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
          ),
          hintText: 'Password',
        ),
        onChanged: (data) {
          password = data;
        },
      ),
    );
  }

  Widget submitButton() {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ElevatedButton(
            child: Text("Submit"),
            onPressed: () async {
              setState(() {
                _isLoading = true;
              });
              Dio dio =
                  Dio(BaseOptions(baseUrl: 'https://api.prediqt.co/api/v2'));
              try {
                Response res = await dio.post(
                  '/login',
                  data: {
                    "username": username,
                    "password": password,
                  },
                  options: Options(
                    headers: {
                      'Authorization':
                          'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE1NTg3OTk0NzksImlzcyI6IlByZWRpcXQifQ.3ml2uHBzpHmvmvMkB9v6ZnLpKJH0vhLpNtrCXzqeBEtatUCfhGwEQ_SWWRnul-x_HqW8VhUUoEXTc1-dK1BSoJjx5z_yoglKijMsgLFlMeG6ojjqnywAqZl5PG-BCPdhjcFNmEKhbvO8Yo4NVaC1RS7aOr-jMoRx9GoUfFBlJHFdSh2E4LvMPT_uQfQIsB9qxg-Lg8t9_R1ueYQbu4ZEsAB59_n2m3GQ6byYO-BvP4wbYk_bK_oEaUh1OoWfHPNGg5myQlVRtQTkX_AQkZfAavQwsgIOJQsZU3eqrZ0kHOA8E0lhiDpXH0-MTYNULk_KQ0kXgvmEoCbQmC0MaJaBlQ',
                      'Content-Type': 'application/json'
                    },
                  ),
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CharacterListScreen()),
                );
              } on DioError catch (err) {
                if (err.type == DioErrorType.RESPONSE) {
                  Flushbar(
                    title: ('Error'),
                    message: (err.response.data['error']),
                    duration: Duration(seconds: 3),
                  )..show(context);
                  //print(err.response.data['error']);//
                  setState(() {
                    _isLoading = false;
                  });
                } else {
                  Flushbar(
                    title: ('Error'),
                    message: ('check your internet connection'),
                    duration: Duration(seconds: 3),
                  )..show(context);
                  setState(() {
                    _isLoading = false;
                  });
                }
              }
            },
          );
  }
}
