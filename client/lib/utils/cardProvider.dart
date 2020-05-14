import 'package:flutter/material.dart';
import "./getProduct.dart";

class OrderedProduct{
  Product product;
  String size;
  int qty;

  OrderedProduct(this.product,this.size,this.qty);
}



class CartModel extends ChangeNotifier {
  final List<OrderedProduct> _items = [];


  int getTotalPrice(){
    int sum=0;
    for (var i = 0; i < _items.length; i++) {
      sum=sum+int.parse(_items[i].product.price)*_items[i].qty;
    }
    return sum;
  }

  String getProductName(){
    String pName="";
    for (var i = 0; i < _items.length; i++) {
      pName=pName+_items[i].product.productName+", ";
    }
    return pName;
  }

  get items =>_items;
  int get len => _items.length;

  int get totalPrice=>getTotalPrice();

  String get productName=>getProductName();

  void add(OrderedProduct item) {
    _items.add(item);
    notifyListeners();
  }
  void removeAll() {
    _items.clear();
    notifyListeners();
  }
}