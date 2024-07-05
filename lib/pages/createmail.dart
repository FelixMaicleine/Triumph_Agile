// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_final_fields, prefer_const_literals_to_create_immutables, use_super_parameters

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triumph_agile/provider/theme.dart';
import 'package:triumph_agile/provider/mailprovider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class CreateMail extends StatefulWidget {
  @override
  _CreateMailState createState() => _CreateMailState();
}

class _CreateMailState extends State<CreateMail> {
  TextEditingController _namaController = TextEditingController();
  TextEditingController _isiController = TextEditingController();
  String _selectedCategory = 'Personal';
  File? _selectedImage;

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('The mail was saved successfully!'),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showLoadingDialog(BuildContext context) {
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
                'Saving...',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        );
      },
    );
  }

  void _hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  Future<void> _saveMail(
      BuildContext context, MailProvider mailProvider) async {
    _showLoadingDialog(context);

    final DateTime selectedDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    final newMail = MailItem(
      nama: _namaController.text,
      isi: _isiController.text,
      kategori: _selectedCategory,
      dateTime: selectedDateTime,
    );

    if (_selectedImage != null) {
      newMail.imagePath = _selectedImage!.path;
    }

    await mailProvider.addMail(newMail);

    _hideLoadingDialog(context);

    _showSnackBar(context);
    Navigator.pop(context);
  }

  Future<void> _saveDraft(
    BuildContext context, MailProvider mailProvider) async {
  _showLoadingDialog(context);

  final DateTime selectedDateTime = DateTime(
    _selectedDate.year,
    _selectedDate.month,
    _selectedDate.day,
    _selectedTime.hour,
    _selectedTime.minute,
  );

  final draftMail = MailItem(
    nama: _namaController.text,
    isi: _isiController.text,
    kategori: _selectedCategory,
    dateTime: selectedDateTime,
  );

  if (_selectedImage != null) {
    draftMail.imagePath = _selectedImage!.path;
  }

  await mailProvider.addDraftMail(draftMail);

  _hideLoadingDialog(context);

  _showSnackBar(context);
}


  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final ThemeData themeData = themeProvider.getCurrentTheme();
    final Color textColor = themeData.textTheme.bodyLarge!.color!;
    final mailProvider = Provider.of<MailProvider>(context, listen: false);
    final Color bottomNavBarColor =
        themeProvider.enableDarkMode ? Colors.grey.shade900 : Colors.white;

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            themeProvider.enableDarkMode ? Colors.grey.shade900 : Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.red,
          ),
          onPressed: () async {
            if (_namaController.text.isNotEmpty || _isiController.text.isNotEmpty) {
              await _saveDraft(context, mailProvider);
            }
            Navigator.pop(context);
          },
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
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        'Title',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: textColor),
                      ),
                    ],
                  ),
                  TextFormField(
                    style: TextStyle(color: textColor),
                    controller: _namaController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: textColor),
                      ),
                      hintText: 'Title',
                      hintStyle: TextStyle(color: textColor),
                      prefixIcon: Icon(Icons.mail, color: textColor),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'Content',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: textColor),
                      ),
                    ],
                  ),
                  TextFormField(
                    style: TextStyle(color: textColor),
                    controller: _isiController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: textColor),
                      ),
                      hintText: 'Content',
                      hintStyle: TextStyle(color: textColor),
                      prefixIcon: Icon(Icons.mail, color: textColor),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'Category',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: textColor),
                      ),
                    ],
                  ),
                  DropdownButtonFormField(
                    style: TextStyle(color: textColor),
                    dropdownColor: themeProvider.enableDarkMode
                        ? Colors.grey.shade800
                        : Colors.white,
                    value: _selectedCategory,
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value.toString();
                      });
                    },
                    items: ['Personal', 'Work', 'Others']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        'Date',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: textColor),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Selected Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}",
                          style: TextStyle(color: textColor),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => _selectDate(context),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            minimumSize: Size(210, 50)),
                        child: Text(
                          'Select Date',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'Time',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: textColor),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Selected Time: ${_selectedTime.format(context)}",
                          style: TextStyle(color: textColor),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => _selectTime(context),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            minimumSize: Size(210, 50)),
                        child: Text(
                          'Select Time',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        'File',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: textColor),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _pickImage,
                        icon: Icon(
                          Icons.photo_library,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Pick Image',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            minimumSize: Size(210, 50)),
                      ),
                      SizedBox(width: 10),
                      if (_selectedImage != null)
                        Image.file(
                          _selectedImage!,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      if (_selectedImage == null)
                        Text(
                          'No image selected.',
                          style: TextStyle(color: textColor),
                        ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () async {
                          if (_namaController.text.isNotEmpty || _isiController.text.isNotEmpty) {
                            await _saveDraft(context, mailProvider);
                          }
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            minimumSize: Size(200, 50)),
                        child: Text(
                          'Back',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _saveMail(context, mailProvider),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              minimumSize: Size(200, 50)),
                          child: Text(
                            'Save',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 75,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: bottomNavBarColor,
        selectedItemColor: Colors.red,
        unselectedItemColor: textColor,
        currentIndex: 2,
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
          if (index == 0) {
            Navigator.pushNamed(context, '/homeuser');
          }
          if (index == 1) {
            Navigator.pushNamed(context, '/mailsuser');
          }
        },
      ),
    );
  }
}
