import 'package:http/http.dart' as http;
import 'dart:convert';

class Product{
  String imageURL,price,productType,productName,companyName,gender,def;
  Product({this.imageURL,this.price,this.productType,this.productName,this.companyName,this.gender,this.def});

  factory Product.fromJson(Map<String,dynamic> json){
    return Product(
      imageURL: json["imageURL"],
      price: json["price"],
      productType: json["productType"],
      productName: json["productName"],
      companyName: json["companyName"],
      gender: json["gender"],
      def:json["def"]
    );
  }
}

Future<List<Product>> getProduct()async{
    var response=await http.get("https://sastobazaar.herokuapp.com/product/getProduct");
    var getData=json.decode(response.body) as List;
    List<Product> productList=getData.map((data)=>Product.fromJson(data)).toList();
    return productList;
}