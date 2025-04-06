import 'package:flutter/material.dart';

class DressModel {
  final String name;
  final double price;
  final String image;
  final List<Color> colors;
  int quantity;
  final int selectedColorIndex;

  DressModel({
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
    required this.colors,
    this.selectedColorIndex = 0,
  }); // Set default selectedColor

  factory DressModel.fromMap(Map<String, dynamic> map) {
    return DressModel(name: map['name'],
                      price: map['price'], 
                      image: map['image'], 
                      quantity: map['quantity'],
                      colors: map['colors']);
  }
}
