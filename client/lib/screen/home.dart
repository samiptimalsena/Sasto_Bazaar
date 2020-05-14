import 'package:flutter/material.dart';
import '../auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import '../utils/getProduct.dart';
import './screenUtils/banner.dart';
import './screenUtils/appBarIcon.dart';
import "dart:math";
import './confirmation.dart';
import './about.dart';
import './viewAll.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Product> productList = [],
      newArrivalProductList = [],
      bestSellingProductList = [],
      featuredProductList = [],
      menProductList = [],
      womenProductList = [],
      electronicProductList=[];

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

  List<Product> generateList(var list) {
    final _random = new Random();
    List<Product> sample = new List<Product>.generate(
        4, (i) => list[_random.nextInt(list.length)]);
    return sample;
  }

  List<Product> generateTypeList(var list, String text) {
    Iterable<Product> tlist = list.where((item) => item.gender == text);
    return List<Product>.from(tlist);
  }

  void initState() {
    super.initState();
    getUserName();
    getProduct().then((result) {
      setState(() {
        productList = result;
        newArrivalProductList = generateList(result);
        bestSellingProductList = generateList(result);
        featuredProductList = generateList(result);
        menProductList = generateTypeList(result, "male");
        womenProductList = generateTypeList(result, "female");
        electronicProductList=generateTypeList(result, "none");
      });
    });
  }

  Widget drawerItem(var icon, String text, VoidCallback action) {
    return ListTile(
      title: Text(text, style: TextStyle(color: Colors.black, fontSize: 17)),
      leading: Icon(
        icon,
      ),
      onTap: () {
        action();
      },
    );
  }

  navigation() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) => About()));
  }

  logOut() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("method") == "fb_login") {
      facebookLogin.logOut();
    }
    if (sharedPreferences.getString("method") == "google_login") {
      _googleSignIn.disconnect();
    }
    sharedPreferences.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => Login()),
        (route) => false);
  }

  Widget categoryItem(String title, var list) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => ViewAll(list, title)));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Text(
          title,
          style: TextStyle(fontSize: 15),
        ),
      ),
    );
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
              icon: myAppBarIcon(),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Confirmation()));
              },
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                  child: Column(
                children: <Widget>[
                  Container(
                    height: 100,
                    child: Image.asset("assets/images/logo.png"),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(
                        "Sasto Bazaar",
                        style: TextStyle(fontSize: 20),
                      ))
                ],
              )),
              ExpansionTile(
                leading: Icon(
                  Icons.category,
                  color: Colors.grey[500],
                ),
                title: Text(
                  "Categories",
                  style: TextStyle(color: Colors.black, fontSize: 17),
                ),
                children: <Widget>[
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        categoryItem("Men's Product", menProductList),
                        categoryItem("Women's Product", womenProductList),
                        categoryItem("Electonic Items", electronicProductList)
                      ],
                    ),
                  )
                ],
              ),
              drawerItem(Icons.info_outline, "About", navigation),
              drawerItem(Icons.help_outline, "Help", navigation),
              drawerItem(Icons.exit_to_app, "Logout", logOut),
            ],
          ),
        ),
        body: newArrivalProductList.length == 0 ||
                bestSellingProductList.length == 0 ||
                featuredProductList.length == 0
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  ImageBanner(
                      newArrivalProductList, "New Arrival", productList),
                  //ImageBanner(bestSellingProductList,"Best Selling",productList),
                  //ImageBanner(featuredProductList,"Featured",productList)
                ],
              )));
  }
}
