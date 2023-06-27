import 'package:flutter/material.dart';
import 'package:noteapp/app/auth/signup.dart';
import 'package:noteapp/app/auth/success.dart';
import 'package:noteapp/app/auth/test.dart';
import 'package:noteapp/app/notes/add.dart';
import 'package:noteapp/app/notes/edit.dart';
import 'app/auth/login.dart';
import 'app/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     title: 'Course PHP Rest API',
      initialRoute: 'home',
      routes: {
       "login" : (context) => Login(),
        "signup" : (context) => SignUp(),
        "home" : (context) => Home(),
        'success' : (context) => Success(),
        'addnotes' : (context) => AddNotes(),
        'editnotes' : (context) => EditNotes(),
        'test' : (context) => Test(),
      },
    );
  }
}
