import 'package:flutter/material.dart';
import './confirmation.dart';
import './screenUtils/appBarIcon.dart';
import './card/productCard.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewAll extends StatelessWidget{
  final title;
  final productList;
  ViewAll(this.productList,this.title);
  @override
  Widget build(BuildContext context){
    return Scaffold(
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
      body: ListView(children: <Widget>[
        Container(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 15,top:15),
            child: Text(
              title,
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 24,
                      fontWeight: FontWeight.w400,)),
            ),
          ),
        Wrap(
          alignment: WrapAlignment.spaceAround,
          children: <Widget>[
        for(var item in productList) Container(margin: const EdgeInsets.only(bottom:10),child: ProductCard(item),)
      ],)
      ],)
    );
  }
}