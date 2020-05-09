import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../screen/home.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _registerFormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _obscureTextC = true;
  bool _obscureText = true;
  bool _isLoading = false;

  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController cPassword = new TextEditingController();
  TextEditingController userName = new TextEditingController();

  registerWithEmail(String email, String password, String name) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {"email": email, "password": password, "name": name};
    var response =
        await http.post("http://192.168.137.1:3000/auth/register", body: data);
    var getData = json.decode(response.body);
    if (getData["token"] != null) {
      sharedPreferences.setString("token", getData['token']);
      sharedPreferences.setString("userName", name);
      sharedPreferences.setString("method", "simple_login");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => Home()),
          (Route<dynamic> route) => false);
    }else{
      setState(() {
        _isLoading = false;
        this.email.text="";
      });
      _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text("Email already exists. Try with new one."),
        backgroundColor: Colors.red,
      ));
    }
  }

  Widget inputText(String text, var handler, var pIcon) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: TextFormField(
        obscureText: text == "Password"
            ? _obscureText
            : text == "Confirm Password" ? _obscureTextC : false,
        controller: handler,
        validator: (String value) {
          if (text == "Email") {
            return !value.contains("@") || !value.endsWith(".com")
                ? "Please enter valid email address"
                : null;
          } else if (text == "Username") {
            return value.isEmpty ? "Please enter some text" : null;
          } else {
            return value.length < 6 ? "Password too short" : null;
          }
        },
        decoration: InputDecoration(
            suffixIcon: _obscureText && text == "Password"
                ? IconButton(
                    icon: Icon(Icons.visibility, color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    })
                : _obscureTextC && text == "Confirm Password"
                    ? IconButton(
                        icon: Icon(Icons.visibility, color: Colors.grey),
                        onPressed: () {
                          setState(() {
                            _obscureTextC = !_obscureTextC;
                          });
                        },
                      )
                    : !_obscureText && text == "Password"
                        ? IconButton(
                            icon:
                                Icon(Icons.visibility_off, color: Colors.grey),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            })
                        : !_obscureTextC && text == "Confirm Password"
                            ? IconButton(
                                icon: Icon(Icons.visibility_off,
                                    color: Colors.grey),
                                onPressed: () {
                                  setState(() {
                                    _obscureTextC = !_obscureTextC;
                                  });
                                },
                              )
                            : null,
            prefixIcon: Icon(
              pIcon,
              color: Colors.grey,
            ),
            labelText: text,
            labelStyle: TextStyle(color: Colors.black87),
            focusedBorder: new UnderlineInputBorder(
                borderSide: new BorderSide(color: Colors.blue))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    return (Scaffold(
      key: _scaffoldKey,
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(top: 25),
                      height: ht / 4,
                      child: Image.asset(
                        "assets/images/logo3.png",
                      )),
                  Container(
                    //height: 390,
                    //width: 190,
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                              "Register",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            )),
                        Form(
                          key: _registerFormKey,
                          child: Column(
                            children: <Widget>[
                              inputText("Username", userName, Icons.person),
                              inputText("Email", email, Icons.email),
                              inputText("Password", password, Icons.lock),
                              inputText(
                                  "Confirm Password", cPassword, Icons.lock),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          margin: const EdgeInsets.only(top: 15, right: 10,bottom: 10),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              // side: BorderSide(color: Colors.red)
                            ),
                            color: Colors.orange[800],
                            child: Text("Register"),
                            textColor: Colors.white,
                            onPressed: () {
                              if (password.text.isNotEmpty &&
                                  cPassword.text.isNotEmpty &&
                                  password.text != cPassword.text) {
                                _scaffoldKey.currentState
                                    .showSnackBar(new SnackBar(
                                  content: new Text("Password didn't matched"),
                                  backgroundColor: Colors.red,
                                ));
                                password.text = "";
                                cPassword.text = "";
                              } else if (_registerFormKey.currentState
                                  .validate()) {
                                setState(() {
                                  _isLoading = true;
                                });
                                registerWithEmail(
                                    email.text, password.text, userName.text);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )));
  }
}
