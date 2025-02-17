// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triumph_agile/provider/theme.dart';

class ChangePass extends StatefulWidget {
  const ChangePass({super.key});

  @override
  State<ChangePass> createState() => _ChangePass();
}

class _ChangePass extends State<ChangePass> {
  void _showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Please use strong password!'),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  String _newPasswordErrorText = '';
  String _confirmPasswordErrorText = '';
  String _newPassword = '';
  String _confirmPassword = '';

  bool _isButtonEnabled = false;

  String? _validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 5) {
      return 'Password must be at least 5 characters long';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one digit';
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  void _updateButtonStatus() {
    setState(() {
      // Memeriksa apakah kedua kata sandi memenuhi kriteria validasi
      _isButtonEnabled = _validatePassword(_newPassword) == null &&
          _validatePassword(_confirmPassword) == null &&
          _newPassword == _confirmPassword;
    });
  }

  void _handleChangePassword() async {
    // Melakukan validasi kata sandi sebelum mengubahnya
    if (_validatePassword(_newPassword) == null) {
      if (_newPassword == _confirmPassword) {
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
                    'Changing password...',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            );
          },
        );

        await Future.delayed(Duration(seconds: 2));

        Navigator.pop(context);

        final snackBar = SnackBar(
          content: Text(
              'Your passsword has been changed successfully. Try logging in with your new password.'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        Navigator.pushNamedAndRemoveUntil(
          context,
          '/loginuser',
          ModalRoute.withName('/'),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Password and confirm password do not match'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final ThemeData themeData = themeProvider.getCurrentTheme();
    final Color textColor = themeData.textTheme.bodyLarge!.color!;
    return Scaffold(
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
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: themeProvider.enableDarkMode
                  ? [Colors.grey.shade800, Colors.red.shade800]
                  : [Colors.red.shade200, Colors.red.shade400],
            ),
          ),
          padding: EdgeInsets.all(10),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(
              children: [
                Text(
                  'New password',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: TextField(
                  onChanged: (value) {
                    _newPassword = value;
                    _newPasswordErrorText = _validatePassword(value) ??
                        ''; // Memperbarui pesan kesalahan
                    _updateButtonStatus(); // Memperbarui status tombol
                    setState(() {}); // Perbarui tampilan
                  },
                  obscureText: true,
                  style: TextStyle(color: textColor),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: textColor),
                      ),
                      hintText: 'Enter your new password',
                      hintStyle: TextStyle(color: textColor),
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: textColor,
                      )),
                ))
              ],
            ),
            Row(
              children: [
                Text(
                  _newPasswordErrorText,
                  style: TextStyle(
                      color: Colors.white, backgroundColor: Colors.red),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Confirm new password',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: TextField(
                  onChanged: (value) {
                    _confirmPassword = value;
                    _confirmPasswordErrorText = _newPassword == value
                        ? ''
                        : 'Passwords do not match'; // Memperbarui pesan kesalahan
                    _updateButtonStatus(); // Memperbarui status tombol
                    setState(() {}); // Perbarui tampilan
                  },
                  obscureText: true,
                  style: TextStyle(color: textColor),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: textColor),
                      ),
                      hintText: 'Confirm your new password',
                      hintStyle: TextStyle(color: textColor),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: textColor,
                      )),
                ))
              ],
            ),
            Row(
              children: [
                Text(
                  _confirmPasswordErrorText,
                  style: TextStyle(
                      color: Colors.white, backgroundColor: Colors.red),
                ),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_isButtonEnabled) {
                  _handleChangePassword();
                } else {
                  _showSnackBar(context); // Call the function directly
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, minimumSize: Size(200, 50)),
              child: Text(
                'Change Password',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Back to',
                  style: TextStyle(color: textColor),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/loginuser');
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.yellow),
                    )),
                Text("/"),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(color: Colors.yellow),
                    )),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
