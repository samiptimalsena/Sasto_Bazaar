import 'package:flutter/material.dart';
import '../auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import '../utils/getProduct.dart';
import './screenUtils/banner.dart';
import "dart:math";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Product> productList = [];
  List<Product> newArrivalProductList = [];
  List<Product> bestSellingProductList = [];
  List<Product> featuredProductList = [];
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

  List<Product> generateList(var list){
    final _random = new Random();
    List<Product> sample=new List<Product>.generate(4,(i)=>list[_random.nextInt(list.length)]);
    return sample;
  }

  void initState() {
    super.initState();
    getUserName();
    getProduct().then((result) {
      setState(() {
        productList = result;
        //newArrivalProductList=generateList(result);
        //bestSellingProductList=generateList(result);
        //featuredProductList=generateList(result);
      });
    });
    
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
              onPressed: (){
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              Text("welcome to sasto bazaar"),
              RaisedButton(
                child: Text("Logout"),
                onPressed: () async {
                  sharedPreferences = await SharedPreferences.getInstance();
                  if (sharedPreferences.getString("method") == "fb_login") {
                    facebookLogin.logOut();
                  }
                  if (sharedPreferences.getString("method") == "google_login") {
                    _googleSignIn.disconnect();
                  }
                  sharedPreferences.clear();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => Login()),
                      (route) => false);
                },
              )
            ],
          ),
        ),
        body: //newArrivalProductList.length == 0 || bestSellingProductList.length==0|| featuredProductList.length==0
           productList.length==0 ? Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  ImageBanner(productList),
                  //ImageBanner(bestSellingProductList),
                  //ImageBanner(featuredProductList)

                ],
              )));
  }
}
