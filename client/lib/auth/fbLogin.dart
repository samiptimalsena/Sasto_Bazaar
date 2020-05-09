import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screen/home.dart';
import 'dart:async';

class FacebookButton extends StatefulWidget{
  @override
  _FacebookButtonState createState()=>_FacebookButtonState();
}


class _FacebookButtonState extends State<FacebookButton>{
  bool condition=true;
  final facebookLogin=FacebookLogin();
  SharedPreferences sharedPreferences;

  loginWithFb()async{
    sharedPreferences=await SharedPreferences.getInstance();
    final result=await facebookLogin.logIn(["email"]);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token=result.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=$token');
        final profile=json.decode(graphResponse.body);
        Map data={"email":profile["email"],"name":profile["name"]};
        await http.post("http://192.168.137.1:3000/auth/login_social",body:data);
        sharedPreferences.setString("token", token);
        sharedPreferences.setString("userName", profile["name"]);
        sharedPreferences.setString("method", "fb_login");
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=>Home()), (route) => false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        return null;
        break;
      case FacebookLoginStatus.error:
        return null;
        break;
    }

}


  @override
  Widget build(BuildContext context){
    return(GestureDetector(
      onDoubleTap: (){},
      onTap:condition? () {
        setState(() => condition = false);
        loginWithFb();
          Timer(Duration(seconds: 15), () => setState(() => condition = true));
        
      }:null,
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        height: 35,
        width: 35,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Image.asset("assets/images/facebook_logo.png"),
      ),
    ));
  }
}

