import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/cardProvider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import './home.dart';

class Confirmation extends StatefulWidget {
  @override
  _ConfirmationState createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  TextEditingController address = TextEditingController();
  TextEditingController phnNo = TextEditingController();
  SharedPreferences sharedPreferences;

  final _detailsFormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget orderedItem(var items) {
    return Container(
      child: ListTile(
        leading: Container(
          width: 60,
          child: Image.network(
            items.product.imageURL,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(items.product.productName),
        subtitle: Row(
          children: <Widget>[
            Container(
                margin: const EdgeInsets.only(right: 15, left: 5),
                child: Text("\$" + items.product.price)),
            Container(
                margin: const EdgeInsets.only(right: 15),
                child: Text("Size: " + items.size)),
            Container(
                margin: const EdgeInsets.only(right: 5),
                child: Text("Qty: " + items.qty.toString())),
          ],
        ),
        //isThreeLine: true,
      ),
    );
  }

  Widget field(String text, var handler, IconData icon) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: TextFormField(
        controller: handler,
        validator: (String value) {
          return value.isEmpty ? "Please enter " + text : null;
        },
        keyboardType: TextInputType.text,
        decoration: InputDecoration(prefixIcon: Icon(icon), labelText: text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.grey[400]),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 15),
            child: Text(
              "Your Orders",
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 22,
                      fontWeight: FontWeight.w400)),
            ),
          ),
          Container(
            child: Consumer<CartModel>(
              builder: (context, cart, child) {
                return Column(
                  children: <Widget>[
                    for (var item in cart.items) orderedItem(item)
                  ],
                );
              },
            ),
          ),
          Consumer<CartModel>(
            builder: (context, cart, child) {
              return Container(
                  margin: const EdgeInsets.only(top: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Total Price: ",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 17,
                                fontWeight: FontWeight.w400)),
                      ),
                      Text(
                        "\$" + cart.totalPrice.toString(),
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 18,
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ));
            },
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 25),
            child: Text(
              "Delivery details",
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 22,
                      fontWeight: FontWeight.w400)),
            ),
          ),
          Form(
            key: _detailsFormKey,
            child: Column(
              children: <Widget>[
                field("Address", address, Icons.location_on),
                field("Phone no.", phnNo, Icons.call),
              ],
            ),
          ),
          Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 20),
              child: Consumer<CartModel>(
                builder: (context, cart, child) {
                  return RaisedButton.icon(
                    elevation: 0.8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    onPressed: () async {
                      sharedPreferences = await SharedPreferences.getInstance();
                      if (_detailsFormKey.currentState.validate()) {
                        if (cart.len != 0) {
                          Map data = {
                            "productName": cart.getProductName(),
                            "userName": sharedPreferences.getString("userName"),
                            "phoneNo": phnNo.text,
                            "address": address.text
                          };
                          var response = await http.post(
                              "https://sastobazaar.herokuapp.com/order/addOrder",
                              body: data);
                          var getData = json.decode(response.body);
                          if (getData["message"] ==
                              "Order successfully placed") {
                            cart.removeAll();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => Home()));
                          }
                        } else {
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text("No products added to cart"),
                            backgroundColor: Colors.red,
                          ));
                        }
                      }
                    },
                    icon: Icon(Icons.done),
                    label: Text("Confirm Order"),
                    textColor: Colors.white,
                    color: Colors.orange[800],
                  );
                },
              ))
        ],
      ),
    );
  }
}
