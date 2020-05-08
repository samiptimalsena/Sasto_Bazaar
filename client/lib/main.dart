import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './auth/login.dart';
import './auth/register.dart';
//import './sample.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Sasto Bazaar",
            initialRoute: '/',
            routes: {
              '/':(context)=>Login(),
              '/register':(context)=>Register()
            },
          )));
}
