import 'package:flutter/material.dart';
import './cardDescription.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatelessWidget{
  final productList;
  ProductCard(this.productList);
  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.only(left:8,bottom: 10),
      child: (
        GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>CardDesciption(productList)));
                },
                        child: Container(
                height: 220,
                width: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[300],
                          offset: Offset(1.0, 5.0),
                          blurRadius: 3.0)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(10),
                          topRight: const Radius.circular(10)),
                      child: SizedBox(
                          height: 155,
                          child: Image.network(
                            productList.imageURL,
                            fit: BoxFit.cover,
                          )),
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 10, top: 7),
                        child: Text(
                          "\$"+productList.price.toString(),
                          style: TextStyle(
                              color: Colors.grey[400],
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        )),
                        Container(
                        margin: const EdgeInsets.only(left: 10, top: 5),
                        child: Text(
                          productList.productName,
                          style:GoogleFonts.firaSans(textStyle:TextStyle( color: Colors.grey[400],
                              fontWeight: FontWeight.w400,
                              fontSize: 15)),
                        ))
                  ],
                ),
              ),
            )
      ),
    );
  }
}