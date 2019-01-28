import 'package:flutter/material.dart';

//
class Product {
  //

  final String title;
  final String description;
  final double price;
  final String image;
  final String location;
  final bool isFavorite;
  final String userId;
  final String userEmail;

  Product({
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.image,
    @required this.location,
    this.isFavorite = false,
    @required this.userId,
    @required this.userEmail,
  });
}
