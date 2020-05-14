import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screen/home.dart';
import 'package:http/http.dart' as http;

class GoogleLogin extends StatefulWidget{
  @override
  _GoogleLoginState createState()=>_GoogleLoginState();
}

class _GoogleLoginState extends State<GoogleLogin>{
  bool condition=true;
  GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email'
  ],
);
  SharedPreferences sharedPreferences;

  loginWithGoogle() async{
    sharedPreferences=await SharedPreferences.getInstance();
      await _googleSignIn.signIn() ;
      if(_googleSignIn.currentUser.id.isNotEmpty){
      Map data={"email":_googleSignIn.currentUser.email,"name":_googleSignIn.currentUser.displayName};
      await http.post("https://sastobazaar.herokuapp.com/auth/login_social",body:data);
      sharedPreferences.setString("token", _googleSignIn.currentUser.id);
      sharedPreferences.setString("userName", _googleSignIn.currentUser.displayName);
      sharedPreferences.setString("method", "google_login");
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=>Home()), (route) => false);
      
  }}

  @override
  Widget build(BuildContext context){
    return(
      GestureDetector(
      onDoubleTap: (){},
      onTap:condition? () {
        setState(() => condition = false);
        loginWithGoogle();
          Timer(Duration(seconds: 3), () => setState(() => condition = true));
        
      }:null,
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        height: 35,
        width: 35,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Image.asset("assets/images/google_logo.png"),
      ),
    )
    );
  }
}