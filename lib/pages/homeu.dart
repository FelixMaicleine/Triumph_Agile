// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_final_fields, prefer_const_literals_to_create_immutables, use_super_parameters, file_names, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triumph2/provider/theme.dart';

class HomeU extends StatefulWidget {
  @override
  _HomeU createState() => _HomeU();
}

class _HomeU extends State<HomeU> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final ThemeData themeData = themeProvider.getCurrentTheme();
    final Color textColor = themeData.textTheme.bodyLarge!.color!;
    final Color cardColor =
        themeProvider.enableDarkMode ? Colors.grey.shade800 : Colors.white;

    final Color bottomNavBarColor =
        themeProvider.enableDarkMode ? Colors.grey.shade900 : Colors.white;

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            themeProvider.enableDarkMode ? Colors.grey.shade900 : Colors.white,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu,
              color: textColor,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Image.asset(
          'assets/logo.png',
          width: 250,
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
      drawer: Drawer(
        child: Container(
            color: themeProvider.enableDarkMode
                ? Colors.grey.shade900
                : Colors.white,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      Container(
                        height: 215,
                        child: DrawerHeader(
                          decoration: BoxDecoration(
                            color: themeProvider.enableDarkMode
                                ? Colors.grey.shade800
                                : Colors.red,
                          ),
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 40.0,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.person,
                                  size: 50.0,
                                  color: Colors.red,
                                ),
                              ),
                              SizedBox(height: 3),
                              Row(
                                children: [
                                  SizedBox(width: 19),
                                  Text(
                                    'User',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Felix Maicleine',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                'felixmaicleine@gmail.com',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.person,
                          color: textColor,
                        ),
                        title: Text(
                          'Profile',
                          style: TextStyle(color: textColor),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/profileuser');
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.edit_document,
                          color: textColor,
                        ),
                        title: Text(
                          'Create Mail',
                          style: TextStyle(color: textColor),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/create');
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.mail,
                          color: textColor,
                        ),
                        title: Text(
                          'All Mails',
                          style: TextStyle(color: textColor),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/mailsuser');
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.archive,
                          color: textColor,
                        ),
                        title: Text(
                          'Inbox',
                          style: TextStyle(color: textColor),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/berstatususer');
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.outbox,
                          color: textColor,
                        ),
                        title: Text(
                          'Outbox',
                          style: TextStyle(color: textColor),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/pendinguser');
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.star,
                          color: textColor,
                        ),
                        title: Text(
                          'Favorite Mails',
                          style: TextStyle(color: textColor),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/favuser');
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.delete,
                          color: textColor,
                        ),
                        title: Text(
                          'Trash',
                          style: TextStyle(color: textColor),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/trash');
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.drafts,
                          color: textColor,
                        ),
                        title: Text(
                          'Draft',
                          style: TextStyle(color: textColor),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/draft');
                        },
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: textColor,
                  ),
                  title: Text(
                    'Logout',
                    style: TextStyle(color: textColor),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/');
                  },
                ),
              ],
            )),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
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
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    'Welcome,',
                    style: TextStyle(
                      fontSize: 23,
                      color: textColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Felix Maicleine',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                padding: EdgeInsets.symmetric(vertical: 20),
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/create');
                    },
                    child: Card(
                      color: cardColor,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.edit_document,
                                size: 50, color: Colors.red),
                            SizedBox(height: 10),
                            Text('Create Mail',
                                style:
                                    TextStyle(fontSize: 18, color: textColor)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/mailsuser');
                    },
                    child: Card(
                      color: cardColor,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.mail, size: 50, color: Colors.red),
                            SizedBox(height: 10),
                            Text('All Mails',
                                style:
                                    TextStyle(fontSize: 18, color: textColor)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/berstatususer');
                    },
                    child: Card(
                      color: cardColor,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.archive, size: 50, color: Colors.red),
                            SizedBox(height: 10),
                            Text('Inbox',
                                style:
                                    TextStyle(fontSize: 18, color: textColor)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/pendinguser');
                    },
                    child: Card(
                      color: cardColor,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.outbox, size: 50, color: Colors.red),
                            SizedBox(height: 10),
                            Text('Outbox',
                                style:
                                    TextStyle(fontSize: 18, color: textColor)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: bottomNavBarColor,
        selectedItemColor: Colors.red,
        unselectedItemColor: textColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Mails',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_document),
            label: 'Create Mail',
          ),
        ],
        onTap: (int index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/mailsuser');
          }
          if (index == 2) {
            Navigator.pushNamed(context, '/create');
          }
        },
      ),
    );
  }
}
