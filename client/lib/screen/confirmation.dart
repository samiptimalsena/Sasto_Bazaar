import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/cardProvider.dart';
import 'package:google_fonts/google_fonts.dart';

class Confirmation extends StatefulWidget {
  @override
  _ConfirmationState createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {

  Widget orderedItem(var items){
    return Container(
      child: ListTile(
                    leading: Image.network(items.product.imageURL),
                    title: Text(items.product.productName),
                    subtitle: Row(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(right:15,left:5),
                          child: Text("\$"+items.product.price)),
                          Container(
                          margin: const EdgeInsets.only(right:15),
                          child: Text("Size: "+items.size)),
                          Container(
                          margin: const EdgeInsets.only(right:5),
                          child: Text("Qty: "+items.qty.toString())),
                      ],
                    ),
                    //isThreeLine: true,
                  ),
    );
  }

  Widget model(var orList){
    return ListView.builder(
      itemCount:orList.length,
      itemBuilder:(context,i){
        return orderedItem(orList[i]);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.grey[400]),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10,top:15),
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
                return Column(children: <Widget>[
                  for(var item in cart.items) orderedItem(item)
                ],);
              },
            ),
          )
        ],
      ),
    );
  }
}
