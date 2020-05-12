import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/cardProvider.dart';

Widget myAppBarIcon() {
    return Consumer<CartModel>(builder: (context, cart, child) {
      return Container(
        width: 30,
        height: 30,
        child: Stack(
          children: [
            Icon(
              Icons.shopping_cart,
              color: Colors.grey[400],
              size: 30,
            ),
           cart.len!=0? Positioned(
              right: 3,
              bottom: 7,
              child: Container(
                width: 15,
                height: 30,
                margin: EdgeInsets.only(top: 5),
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffc32c37),
                      
                      ),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Center(
                      child: Text(
                        cart.len.toString(),
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                ),
              ),
            ):Container()
          ],
        ),
      );
    });
  }