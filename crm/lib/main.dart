import 'package:crm/view/contact/contact_home_page.dart';
import 'package:crm/view/login/sign_up.dart';
import 'package:crm/view/login/sign_up_page_2.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => ContactHomePage(),
      },
      
    );
  }
}

