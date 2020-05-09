import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../screen/home.dart';
import './fbLogin.dart';
import './googleLogin.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  SharedPreferences sharedPreferences;
  final _loginFormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var _obscureText = true;
  var isLoading=false;


  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  checkLoginStatus()async{
    sharedPreferences=await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token")!=null){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=>Home()), (route) => false);
    }
  }

  signInWithEmail(String email,String password) async{
    sharedPreferences=await SharedPreferences.getInstance();
    Map data={"email":email,"password":password};
    var response=await http.post("http://192.168.137.1:3000/auth/login",body:data);
    var getData=json.decode(response.body);
    if(getData["token"]!=null){
      sharedPreferences.setString("token", getData["token"]);
      sharedPreferences.setString("userName",getData["name"]);
      sharedPreferences.setString("method","simple_login");
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=>Home()), (route) => false);
    }else {
      setState(() {
        isLoading = false;
      });
      _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text("Emaill and Password didn't matched"),
        backgroundColor: Colors.red,
      ));
    }
  }

  Widget inputText(String text, var handler) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: TextFormField(
          validator: (String value) {
            if (text == "Email") {
              return !value.contains("@") || !value.endsWith(".com")
                  ? "Please enter a valid email address"
                  : null;
            } else {
              return value.isEmpty ? "Please enter Password" : null;
            }
          },
          controller: handler,
          keyboardType:
              text == "Email" ? TextInputType.emailAddress : TextInputType.text,
          obscureText: text == "Password" ? _obscureText : false,
          decoration: InputDecoration(
              prefixIcon: Icon(
                text == "Email" ? Icons.email : Icons.lock,
                color: Colors.grey,
              ),
              suffixIcon: _obscureText && text == "Password"
                  ? IconButton(
                      icon: Icon(
                        Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : !_obscureText && text == "Password"
                      ? IconButton(
                          icon: Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        )
                      : null,
              labelText: text,
              labelStyle: TextStyle(color: Colors.black87),
              focusedBorder: new UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue)))),
    );
  }

  

  void initState(){
    super.initState();
    checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    return (Scaffold(
      key: _scaffoldKey,
      body: isLoading?Center(child: CircularProgressIndicator(),) :ListView(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: 25),
              height: ht / 4,
              child: Image.asset(
                "assets/images/logo3.png",
                // fit:BoxFit.cover
              )),
          Container(
           // height: 290,
            //width: 190,
            margin: const EdgeInsets.fromLTRB(10,40,10,0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[300],
                    offset: Offset(5.0, 5.0),
                    blurRadius: 4.0)
              ],
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: Text(
                      "Login",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    )),
                Container(
                  margin: const EdgeInsets.only(top:10),
                  child: Form(
                    key: _loginFormKey,
                    child: Column(
                      children: <Widget>[
                        inputText("Email", email),
                        inputText("Password", password)
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  margin: const EdgeInsets.only(top: 25, right: 10,bottom: 10),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      // side: BorderSide(color: Colors.red)
                    ),
                    color: Colors.orange[800],
                    child: Text("Sign In"),
                    textColor: Colors.white,
                    onPressed: () {
                      if(_loginFormKey.currentState.validate()){
                        setState(() {
                          isLoading=true;
                        });
                      signInWithEmail(email.text, password.text);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 45.0, right: 15.0),
                    child: Divider(
                      color: Colors.grey[300],
                      height: 90,
                      thickness: 1.5,
                    )),
              ),
              Text(
                "Social Login",
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
              ),
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 15.0, right: 45.0),
                    child: Divider(
                      color: Colors.grey[300],
                      height: 90,
                      thickness: 1.5,
                    )),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              /*loginButton("assets/images/facebook_logo.png",
                  () => {loginWithFb(facebookLogin)})*/
                  FacebookButton(),
                  GoogleLogin(),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "New User?",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/register');
                  },
                  child: Container(
                    child: Text(
                      " Sign Up",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
