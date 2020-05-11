import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../card/productCard.dart';

class ImageBanner extends StatelessWidget{
  final productList;
  ImageBanner(this.productList);
  @override
  Widget build(BuildContext context){
    return(
      Column(children: <Widget>[
        Container(
                    margin: EdgeInsets.only(left: 5, right: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "New Arrival",
                          style: GoogleFonts.arimo(
                              textStyle: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500)),
                        ),
                        Text("See all",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: Colors.orange[800],
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)))
                      ],
                    ),
                  ),
                  Container(
                      height: 230,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: productList.length,
                          itemBuilder: (context, i) {
                            return ProductCard(productList[i]);
                          }))
      ],)
    );
}}