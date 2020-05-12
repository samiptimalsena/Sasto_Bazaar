import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './auth/login.dart';
import 'package:provider/provider.dart';
//import 'package:flutter/foundation.dart';
import './utils/cardProvider.dart';
//import './auth/register.dart';
//import './sample.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(
        ChangeNotifierProvider(
          create: (context)=>CartModel(),
          child: MyApp(),
        )
      ));
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title:"Sasto Bazaar",
      home: Login()
    );
  }
}

