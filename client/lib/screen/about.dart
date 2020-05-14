import 'package:flutter/material.dart';
import './screenUtils/appBarIcon.dart';
import './confirmation.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatelessWidget{
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
                Navigator.of(context).push(MaterialPageRoute(builder:(BuildContext context)=>Confirmation()));
              },
            )
          ],
        ),
      body: ListView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        Container(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 15),
            child: Text(
              "About Us",
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 22,
                      fontWeight: FontWeight.w400)),
            ),
          ),
        Container(child: Image.asset("assets/images/logo.png"),),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Sasto Bazaar is a leading e-commerce startup in Nepal. As our motto suggest 'We deliver fast', we have been serving our customer as fast as possible. We hope to gain more trust from our valuable customers in upcoming years.",
          style:TextStyle(fontSize: 18)),
        ),
        Padding(
          padding: const EdgeInsets.only(top:10,left:10),
          child: Text("E-mail: sastobazaar425@gmail.com",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
        ),
        Padding(
          padding: const EdgeInsets.only(top:10,left:10),
          child: Text("Contact no: 9843674540",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
        ),
        Padding(
          padding: const EdgeInsets.only(top:40),
          child: Center(child: Text("Happy Shopping with",style: TextStyle(fontSize:18),),),
        ),
        Padding(
          padding: const EdgeInsets.only(top:10),
          child: Center(child: Text("Sasto Bazaar",style: TextStyle(fontSize:22,fontWeight:FontWeight.w600),),),
        )
      ],)
    );
  }
}