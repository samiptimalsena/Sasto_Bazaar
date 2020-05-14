import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../card/productCard.dart';
import '../viewAll.dart';

class ImageBanner extends StatelessWidget{
  final productList,name,totalProductList;
  ImageBanner(this.productList,this.name,this.totalProductList);
  @override
  Widget build(BuildContext context){
    return(
      Column(children: <Widget>[
        Container(
                    margin: EdgeInsets.only(left: 5, right: 10, bottom: 10,top:15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          name,
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 22,
                                  fontWeight: FontWeight.w400)),
                        ),
                        GestureDetector(
                          onTap: (){
                           Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>ViewAll(totalProductList,"Our Products")));
                          },
                                                  child: Text("See all",
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: Colors.orange[800],
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600))),
                        )
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