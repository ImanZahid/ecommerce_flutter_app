// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DressModel {
  final String name;
  final double price;
  final String image;
  final List<int> colors;
  int quantity;
  final int selectedColorIndex;
  List<Color> actualColors = List.empty();

  DressModel({
    required this.name,
    required this.price,
    required this.image,
    required this.colors,
    required this.quantity,
    this.selectedColorIndex = 0,
  });

  List<Color> getColors() {
    actualColors = actualColors.isEmpty ? List<Color>.from((colors).map<Color>((x) => Color(x))): actualColors;
    return actualColors;
  }

  factory DressModel.fromMap(Map<String, dynamic> map) {
    return DressModel(
      name: map['name']! as String,
      price: map['price']! as double,
      image: map['image']! as String,
      colors: List<int>.from(map['colors']!),
      quantity: map['quantity']! as int,
    );
  }

  DressModel copyWith({
    String? name,
    double? price,
    String? image,
    List<int>? colors,
    int? quantity,
    int? selectedColorIndex,
  }) {
    return DressModel(
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      colors: colors ?? this.colors,
      quantity: quantity ?? this.quantity,
      selectedColorIndex: selectedColorIndex ?? this.selectedColorIndex,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'price': price,
      'image': image,
      'colors': colors,
      'quantity': quantity,
    };
  }

  String toJson() => json.encode(toMap());

  factory DressModel.fromJson(String source) => DressModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DressModel(name: $name, price: $price, image: $image, colors: $colors, quantity: $quantity, selectedColorIndex: $selectedColorIndex)';
  }

  @override
  bool operator ==(covariant DressModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.price == price &&
      other.image == image &&
      listEquals(other.colors, colors) &&
      other.quantity == quantity &&
      other.selectedColorIndex == selectedColorIndex;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      price.hashCode ^
      image.hashCode ^
      colors.hashCode ^
      quantity.hashCode ^
      selectedColorIndex.hashCode;
  }
}
