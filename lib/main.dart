import 'package:flutter/material.dart';
import 'package:triumph_agile/pages/approvedadmin.dart';
import 'package:triumph_agile/pages/declinedadmin.dart';
import 'package:triumph_agile/pages/draft.dart';
import 'package:triumph_agile/pages/editprofileadmin.dart';
import 'package:triumph_agile/pages/favadmin.dart';
import 'package:triumph_agile/pages/favuser.dart';
import 'package:triumph_agile/pages/inboxuser.dart';
import 'package:triumph_agile/pages/editprofileuser.dart';
import 'package:triumph_agile/pages/homea.dart';
import 'package:triumph_agile/pages/homeu.dart';
import 'package:triumph_agile/pages/mailsadmin.dart';
import 'package:triumph_agile/pages/loginadmin.dart';
import 'package:triumph_agile/pages/pendingadmin.dart';
import 'package:triumph_agile/pages/outboxuser.dart';
import 'package:triumph_agile/pages/peran.dart';
import 'package:triumph_agile/pages/profileadmin.dart';
import 'package:triumph_agile/pages/profileuser.dart';
import 'package:triumph_agile/pages/landing.dart';
import 'package:triumph_agile/pages/loginuser.dart';
import 'package:triumph_agile/pages/register.dart';
import 'package:triumph_agile/pages/forgotpass.dart';
import 'package:triumph_agile/pages/trash.dart';
import 'package:triumph_agile/pages/verifcode.dart';
import 'package:triumph_agile/pages/changepass.dart';
import 'package:triumph_agile/pages/mailsuser.dart';
import 'package:triumph_agile/pages/createmail.dart';
import 'package:provider/provider.dart';
import 'package:triumph_agile/provider/theme.dart';
import 'package:triumph_agile/provider/mailprovider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => MailProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      initialRoute: '/',
      routes: {
        '/': (context) => Landing(),
        '/peran': (context) => Peran(),
        '/loginuser': (context) => LoginUser(),
        '/loginadmin': (context) => LoginAdmin(),
        '/forgot': (context) => ForgotPass(),
        '/verify': (context) => VerifCode(),
        '/change': (context) => ChangePass(),
        '/register': (context) => Register(),
        '/homeuser': (context) => HomeU(),
        '/homeadmin': (context) => HomeA(),
        '/mailsuser': (context) => MailsUser(),
        '/mailsadmin': (context) => MailsAdmin(),
        '/create': (context) => CreateMail(),
        '/profileuser': (context) => ProfileUser(),
        '/profileadmin': (context) => ProfileAdmin(),
        '/editprofileuser': (context) => EditProfileUser(),
        '/editprofileadmin': (context) => EditProfileAdmin(),
        '/pendingadmin': (context) => PendingAdmin(),
        '/approvedadmin': (context) => ApprovedAdmin(),
        '/notapprovedadmin': (context) => DeclinedAdmin(),
        '/berstatususer': (context) => InboxUser(),
        '/pendinguser': (context) => OutboxUser(),
        '/favadmin': (context) => FavAdmin(),
        '/favuser': (context) => FavUser(),
        '/trash': (context) => Trash(),
        '/draft': (context) => Draft(),
      },
    );
  }
}

// tes 
