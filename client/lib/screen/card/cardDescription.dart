import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../utils/cardProvider.dart';

class CardDesciption extends StatefulWidget {
  final product;
  CardDesciption(this.product);
  @override
  _CardDescriptionState createState() => _CardDescriptionState();
}

class _CardDescriptionState extends State<CardDesciption> {
  Offset offset;
  double _scale = 1.0;
  int count=1;
  var productList;

  Color mButtonFillColor = Colors.white,
      lButtonFillColor = Colors.black,
      xlButtonFillColor = Colors.white,
      xxlButtonFillColor = Colors.white,
      sButtonFillColor = Colors.white;
  Color sButtonBorderColor = Colors.grey[500],
      mButtonBorderColor = Colors.grey[500],
      lButtonBorderColor = Colors.black,
      xlButtonBorderColor = Colors.grey[500],
      xxlButtonBorderColor = Colors.grey[500];
  Color sButtonTextColor = Colors.grey[400],
      mButtonTextColor = Colors.grey[400],
      lButtonTextColor = Colors.grey[50],
      xlButtonTextColor = Colors.grey[400],
      xxlButtonTextColor = Colors.grey[400];

  Widget sizeButton(String text) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: SizedBox(
        height: 40,
        width: 40,
        child: (RaisedButton(
          elevation: 0,
          padding: const EdgeInsets.all(0.0),
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: text == "S"
                      ? sButtonBorderColor
                      : text == "M"
                          ? mButtonBorderColor
                          : text == "L"
                              ? lButtonBorderColor
                              : text == "XL"
                                  ? xlButtonBorderColor
                                  : text == "XXL"
                                      ? xxlButtonBorderColor
                                      : null),
              borderRadius: BorderRadius.circular(2)),
          color: text == "S"
              ? sButtonFillColor
              : text == "M"
                  ? mButtonFillColor
                  : text == "L"
                      ? lButtonFillColor
                      : text == "XL"
                          ? xlButtonFillColor
                          : text == "XXL" ? xxlButtonFillColor : null,
          onPressed: () {
            setState(() {
              if (text == "S") {
                sButtonFillColor = Colors.black;
                sButtonBorderColor = Colors.black;
                sButtonTextColor = Colors.grey[50];
                mButtonFillColor = lButtonFillColor =
                    xlButtonFillColor = xxlButtonFillColor = Colors.white;
                mButtonBorderColor = lButtonBorderColor = xlButtonBorderColor =
                    xxlButtonBorderColor = Colors.grey[500];
                mButtonTextColor = lButtonTextColor =
                    xlButtonTextColor = xxlButtonTextColor = Colors.grey[400];
              }
              if (text == "M") {
                mButtonFillColor = Colors.black;
                mButtonBorderColor = Colors.black;
                mButtonTextColor = Colors.grey[50];
                sButtonFillColor = lButtonFillColor =
                    xlButtonFillColor = xxlButtonFillColor = Colors.white;
                sButtonBorderColor = lButtonBorderColor = xlButtonBorderColor =
                    xxlButtonBorderColor = Colors.grey[500];
                sButtonTextColor = lButtonTextColor =
                    xlButtonTextColor = xxlButtonTextColor = Colors.grey[400];
              }
              if (text == "L") {
                lButtonFillColor = Colors.black;
                lButtonBorderColor = Colors.black;
                lButtonTextColor = Colors.grey[50];
                mButtonFillColor = sButtonFillColor =
                    xlButtonFillColor = xxlButtonFillColor = Colors.white;
                mButtonBorderColor = sButtonBorderColor = xlButtonBorderColor =
                    xxlButtonBorderColor = Colors.grey[500];
                mButtonTextColor = sButtonTextColor =
                    xlButtonTextColor = xxlButtonTextColor = Colors.grey[400];
              }
              if (text == "XL") {
                xlButtonFillColor = Colors.black;
                xlButtonBorderColor = Colors.black;
                xlButtonTextColor = Colors.grey[50];
                mButtonFillColor = lButtonFillColor =
                    sButtonFillColor = xxlButtonFillColor = Colors.white;
                mButtonBorderColor = lButtonBorderColor = sButtonBorderColor =
                    xxlButtonBorderColor = Colors.grey[500];
                mButtonTextColor = lButtonTextColor =
                    sButtonTextColor = xxlButtonTextColor = Colors.grey[400];
              }
              if (text == "XXL") {
                xxlButtonFillColor = Colors.black;
                xxlButtonBorderColor = Colors.black;
                xxlButtonTextColor = Colors.grey[50];
                mButtonFillColor = lButtonFillColor =
                    xlButtonFillColor = sButtonFillColor = Colors.white;
                mButtonBorderColor = lButtonBorderColor =
                    xlButtonBorderColor = sButtonBorderColor = Colors.grey[500];
                mButtonTextColor = lButtonTextColor =
                    xlButtonTextColor = sButtonTextColor = Colors.grey[400];
              }
            });
          },
          textColor: text == "S"
              ? sButtonTextColor
              : text == "M"
                  ? mButtonTextColor
                  : text == "L"
                      ? lButtonTextColor
                      : text == "XL"
                          ? xlButtonTextColor
                          : text == "XXL" ? xxlButtonTextColor : null,
          child: Text(text),
        )),
      ),
    );
  }

  Widget quantityButton(var icon){
    return Container(
      margin: const EdgeInsets.only(left:10),
      color: icon==Icons.remove?Colors.grey[100]:Colors.grey[200],
      child:SizedBox(
      height: 40,width: 40,
    child: IconButton(
      onPressed: (){
        if(count>=1 && icon==Icons.add ){
          setState(() {
            count++;
          });
        }else if(count>1 && icon==Icons.remove){
          setState(() {
            count--;
          });
        }
      },
      icon: Icon(icon,color:icon==Icons.remove?Colors.grey[350]:Colors.grey[500],),
    )));
  }

  @override
  void initState(){
    super.initState();
    productList=widget.product;
  }

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
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
        body: ListView(
          children: <Widget>[
            GestureDetector(
              onScaleStart: (ScaleStartDetails details) {
                print(details.localFocalPoint);

                setState(() {
                  offset = details.localFocalPoint;
                });
              },
              onScaleUpdate: (ScaleUpdateDetails details) {
                setState(() {
                  _scale = details.scale;
                });
              },
              onScaleEnd: (ScaleEndDetails details) {
                setState(() {
                  _scale = 1.0;
                });
              },
              child: Container(
                  height: ht / 2.3,
                  color: Colors.white,
                  child: Transform(
                      transform: Matrix4.diagonal3(Vector3(
                          _scale > 1.0 ? _scale : 1.0,
                          _scale > 1.0 ? _scale : 1.0,
                          _scale > 1.0 ? _scale : 1.0)),
                      origin: offset,
                      child: Image.network(
                        productList.imageURL,
                        fit: BoxFit.fill,
                      ))),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: Text(productList.productName,
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.bold)))),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Text(productList.companyName.toUpperCase(),
                        style: TextStyle(
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w500,
                            fontSize: 15)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: Text(
                      "\$"+productList.price.toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Divider(
                      indent: 10,
                      endIndent: 10,
                      color: Colors.grey[200],
                      thickness: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top:20),
              child: Row(
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(right: 10, left: 10),
                      child: Text("Size",style: GoogleFonts.roboto(textStyle:TextStyle(fontSize: 16,fontWeight:FontWeight.bold)),)),
                  sizeButton("S"),
                  sizeButton("M"),
                  sizeButton("L"),
                  sizeButton("XL"),
                  sizeButton("XXL")
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top:25),
              child: Row(children: <Widget>[
                Container(
                      margin: const EdgeInsets.only(right: 15, left: 10),
                      child: Text("Qty",style: GoogleFonts.roboto(textStyle:TextStyle(fontSize: 16,fontWeight:FontWeight.bold)),)),
                quantityButton(Icons.remove),
                Container(
                  margin: const EdgeInsets.only(left:20,right:10),
                  child: Text("$count",style: GoogleFonts.roboto(textStyle:TextStyle(fontSize: 20,fontWeight:FontWeight.w500)))),
                quantityButton(Icons.add)
              ],),
            ),
            Container(
              margin: const EdgeInsets.only(top:10),
              alignment: Alignment.center,
              child: Consumer<CartModel>(
                builder: (context,cart,child){
                 return RaisedButton.icon(
                elevation: 0.8,
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)
                ) ,
                onPressed: (){
                  cart.add(productList);
                  print("added");
                },
                icon: Icon(Icons.add_shopping_cart),
                label: Text("Add to Cart"),
                textColor: Colors.white,
                color: Colors.orange[800],
              );
                },
              )
            )
          ],
        )));
  }
}
