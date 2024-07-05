// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triumph2/provider/theme.dart';

class EditProfileAdmin extends StatefulWidget {
  const EditProfileAdmin({super.key});

  @override
  State<EditProfileAdmin> createState() => _EditProfileAdmin();
}

class _EditProfileAdmin extends State<EditProfileAdmin> {
  String _selectedGender = 'Not Telling';
  final List<String> _genders = ['Not Telling', 'Male', 'Female'];
  IconData _selectedIcon = Icons.person;

  void _updateSelectedIcon() {
    switch (_selectedGender) {
      case 'Male':
        _selectedIcon = Icons.male;
        break;
      case 'Female':
        _selectedIcon = Icons.female;
        break;
      case 'Not Telling':
        _selectedIcon = Icons.remove;
        break;
      default:
        _selectedIcon = Icons.person;
        break;
    }
  }

  String _emailErrorText = '';

  void _validateForm() {
    setState(() {
      _emailErrorText = '';
    });

    bool isEmailValid = _emailController.text.isNotEmpty &&
        RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
            .hasMatch(_emailController.text);
    if (!isEmailValid) {
      setState(() {
        _emailErrorText = 'Invalid email address';
      });
    }
  }

  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: themeProvider.enableDarkMode
                ? [Colors.grey.shade800, Colors.red.shade800]
                : [Colors.red.shade200, Colors.red.shade400],
          ),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Name',
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
                        style: TextStyle(color: textColor),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: textColor),
                          ),
                          hintText: 'Enter your new name',
                          hintStyle: TextStyle(color: textColor),
                          prefixIcon:
                              Icon(Icons.person_outline, color: textColor),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Username',
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
                        style: TextStyle(color: textColor),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: textColor),
                          ),
                          hintText: 'Enter your new username',
                          hintStyle: TextStyle(color: textColor),
                          prefixIcon:
                              Icon(Icons.person_outline, color: textColor),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'E-mail',
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
                        controller: _emailController,
                        style: TextStyle(color: textColor),
                        onChanged: (value) {
                          _validateForm(); // Validasi email saat nilai berubah
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: textColor),
                          ),
                          hintText: 'Enter your email',
                          hintStyle: TextStyle(color: textColor),
                          prefixIcon: Icon(Icons.email, color: textColor),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      _emailErrorText,
                      style: TextStyle(
                          color: Colors.white, backgroundColor: Colors.red),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Gender',
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
                      child: DropdownButtonFormField<String>(
                        value: _selectedGender,
                        items: _genders.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedGender = newValue!;
                            _updateSelectedIcon();
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: textColor),
                          ),
                          hintText: 'Select gender',
                          hintStyle: TextStyle(color: textColor),
                          prefixIcon: Icon(
                            _selectedIcon,
                            color: textColor,
                          ),
                        ),
                        style: TextStyle(color: textColor),
                        dropdownColor: themeProvider.enableDarkMode
                            ? Colors.grey.shade800
                            : Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Admin Code',
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
                        style: TextStyle(color: textColor),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: textColor),
                          ),
                          hintText: 'Enter your new admin code',
                          hintStyle: TextStyle(color: textColor),
                          prefixIcon:
                              Icon(Icons.qr_code_2, color: textColor),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, minimumSize: Size(200, 50)),
                  child: Text(
                    'Save',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
