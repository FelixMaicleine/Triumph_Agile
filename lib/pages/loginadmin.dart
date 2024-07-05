// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triumph2/provider/theme.dart';

class LoginAdmin extends StatefulWidget {
  const LoginAdmin({super.key});

  @override
  State<LoginAdmin> createState() => _LoginAdmin();
}

class _LoginAdmin extends State<LoginAdmin> {
  void _showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('You must agree to the terms of service!'),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _handleLogin(BuildContext context) async {
    if (_agreedToTerms) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
          backgroundColor: Colors.red,
          content: Row(
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
              SizedBox(width: 20),
              Text(
                'Logging In...',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        );
        },
      );

      await Future.delayed(Duration(seconds: 2));

      Navigator.pop(context);

      // Tampilkan SnackBar untuk login success
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login Success'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      Navigator.pushNamedAndRemoveUntil(
        context,
        '/homeadmin',
        ModalRoute.withName('/'),
      );
    } else {
      _showSnackBar(context);
    }
  }

  final TextEditingController _usernameController = TextEditingController();

  Map<String, String>? _message;

  int? _staySignedIn;
  bool _agreedToTerms = false;

  @override
  Widget build(BuildContext context) {
    _message =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final ThemeData themeData = themeProvider.getCurrentTheme();
    final Color textColor = themeData.textTheme.bodyLarge!.color!;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor:
            themeProvider.enableDarkMode ? Colors.grey.shade900 : Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.red,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Image.asset(
          'assets/logo.png',
          width: 250,
          // height: 3000,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              themeProvider.enableDarkMode = !themeProvider.enableDarkMode;
            },
            icon: Icon(
              themeProvider.enableDarkMode
                  ? Icons.wb_sunny
                  : Icons.nightlight_round,
              color:
                  themeProvider.enableDarkMode ? Colors.yellow : Colors.black,
            ),
          ),
        ],
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: themeProvider.enableDarkMode
                  ? [Colors.grey.shade800, Colors.red.shade800]
                  : [Colors.red.shade200, Colors.red.shade400],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_message != null)
                Column(
                  children: [
                    Text(_message!['line1']!,
                        style: TextStyle(color: textColor)),
                    Text(_message!['line2']!,
                        style: TextStyle(color: textColor)),
                  ],
                ),
              Row(
                children: [
                  Text(
                    'Username',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _usernameController,
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: textColor),
                        ),
                        hintText: 'Enter your username',
                        hintStyle: TextStyle(color: textColor),
                        prefixIcon: Icon(Icons.person, color: textColor),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: textColor),
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: textColor),
                        ),
                        hintText: 'Enter your password',
                        hintStyle: TextStyle(color: textColor),
                        prefixIcon: Icon(Icons.lock, color: textColor),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Admin Code',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: textColor),
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: textColor),
                        ),
                        hintText: 'Enter your admin code',
                        hintStyle: TextStyle(color: textColor),
                        prefixIcon: Icon(Icons.lock, color: textColor),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Stay signed in?',
                        style: TextStyle(color: textColor),
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 1,
                            groupValue: _staySignedIn,
                            onChanged: (value) {
                              setState(() {
                                _staySignedIn = value;
                              });
                            },
                            fillColor:
                                MaterialStateProperty.all<Color>(textColor),
                          ),
                          Text(
                            'Yes',
                            style: TextStyle(color: textColor),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 0,
                            groupValue: _staySignedIn,
                            onChanged: (value) {
                              setState(() {
                                _staySignedIn = value;
                              });
                            },
                            fillColor:
                                MaterialStateProperty.all<Color>(textColor),
                          ),
                          Text(
                            'No',
                            style: TextStyle(color: textColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/forgot');
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.yellow),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: _agreedToTerms,
                    onChanged: (bool? value) {
                      setState(() {
                        _agreedToTerms = value!;
                      });
                    },
                    fillColor: MaterialStateProperty.all<Color>(textColor),
                  ),
                  Text(
                    'I agree to the terms of service',
                    style: TextStyle(color: textColor),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () => _handleLogin(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: Size(200, 50),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Doesn't have an account yet?",
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.yellow,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
