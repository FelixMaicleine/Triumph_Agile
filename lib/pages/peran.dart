// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triumph2/provider/theme.dart';

class Peran extends StatefulWidget {
  const Peran({super.key});

  @override
  State<Peran> createState() => _Peran();
}

class _Peran extends State<Peran> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final ThemeData themeData = themeProvider.getCurrentTheme();
    final Color textColor = themeData.textTheme.bodyLarge!.color!;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: themeProvider.enableDarkMode
              ? Colors.grey.shade900
              : Colors.white,
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
                color: themeProvider.enableDarkMode
                    ? Colors.yellow
                    : Color.fromARGB(255, 5, 5, 118),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to Triumph',
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: textColor),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/loginadmin');
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          minimumSize: Size(100, 50)),
                      child: Text(
                        'Admin',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/loginuser');
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          minimumSize: Size(100, 50)),
                      child: Text(
                        'User',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
