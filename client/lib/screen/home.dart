import 'package:flutter/material.dart';
import '../auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState()=>_HomeState();
}

class _HomeState extends State<Home>{
  @override
  Widget build(BuildContext context){
    return(
      Scaffold(
        body: Column(children: <Widget>[
          Center(child: Text("hello"),),
          RaisedButton(child: Text("Logout"),
          onPressed: () async{
            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
           sharedPreferences.clear();
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=>Login()), (route) => false);
          },)
        ],)
      )
    );
  }
}