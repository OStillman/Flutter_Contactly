import 'package:flutter/material.dart';
import 'helpers/constants.dart';
import 'loginpage.dart';
import 'homepage.dart';

void main() => runApp(ContactlyApp());

class ContactlyApp extends StatelessWidget {

  //Allows the use of tags to reference each individual page
  final routes = <String, WidgetBuilder>{
    loginPageTag: (context) => LoginPage(),
    homePageTag: (context) => HomePage(),
  };

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false, //Removes the debug label
      title: appTitle, //From constants
      theme: new ThemeData(
        primaryColor: appDarkGreyColor,
      ),
      home: LoginPage(),
      routes: routes
    );
  }
}

