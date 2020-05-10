import 'package:flutter/material.dart';
import '../auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_fonts/google_fonts.dart';
import './cardDescription.dart';

 

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SharedPreferences sharedPreferences;
  String userName = "achha";
  final facebookLogin = FacebookLogin();
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>['email'],
  );

  getUserName() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userName = sharedPreferences.getString("userName");
    });
  }

  void initState() {
    super.initState();
    getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.grey[400]),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              size: 25,
            ),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[Text("welcome to sasto bazaar"),
          RaisedButton(child: Text("Logout"),
          onPressed: () async{
           sharedPreferences = await SharedPreferences.getInstance();
           if(sharedPreferences.getString("method")=="fb_login"){
           facebookLogin.logOut();
           }
           if(sharedPreferences.getString("method")=="google_login"){
              _googleSignIn.disconnect();
           }
           sharedPreferences.clear();
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=>Login()), (route) => false);
          },)
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>CardDesciption()));
              },
                      child: Container(
              height: 220,
              width: 140,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[300],
                        offset: Offset(1.0, 5.0),
                        blurRadius: 3.0)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10),
                        topRight: const Radius.circular(10)),
                    child: SizedBox(
                        height: 155,
                        child: Image.network(
                          "https://drive.google.com/uc?export=view&id=1mfvB7YXPpaNzQBoX5OEgX_tJhsNBQ5JM",
                          fit: BoxFit.cover,
                        )),
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 10, top: 7),
                      child: Text(
                        "\$30.00",
                        style: TextStyle(
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      )),
                      Container(
                      margin: const EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        "Woman T-shirt",
                        style:GoogleFonts.firaSans(textStyle:TextStyle( color: Colors.grey[400],
                            fontWeight: FontWeight.w400,
                            fontSize: 15)),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
