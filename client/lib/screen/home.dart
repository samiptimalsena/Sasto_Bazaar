import 'package:flutter/material.dart';
import '../auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState()=>_HomeState();
}


class _HomeState extends State<Home>{
  SharedPreferences sharedPreferences;
  String userName="";
  GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email'
  ],
);
  
  getUserName()async{
    sharedPreferences=await SharedPreferences.getInstance();
    setState(() {
      userName=sharedPreferences.getString("userName");
    });
  }
  
  void initState(){
    super.initState();
    getUserName();
  }

  @override
  Widget build(BuildContext context){
    return(
      Scaffold(
        body: ListView(children: <Widget>[
          Center(child: Text(userName),),
          RaisedButton(child: Text("Logout"),
          onPressed: () async{
           sharedPreferences = await SharedPreferences.getInstance();
           _googleSignIn.disconnect();
           sharedPreferences.clear();
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=>Login()), (route) => false);
          },)
        ],)
      )
    );
  }
}