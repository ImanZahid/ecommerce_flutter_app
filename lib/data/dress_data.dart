
import 'package:ecommerce_flutter_app/domain/shopping/dress_model.dart';
import 'package:flutter/material.dart';

final List<DressModel> dressdata = [
    DressModel(name: "Bouquet Dress", image: "assets/images/dress1.png", price: 39.99, quantity: 1,
      colors: [const Color.fromARGB(255, 160, 216, 6), const Color.fromARGB(255, 108, 196, 7), Colors.purple, const Color.fromARGB(255, 248, 35, 99)],),
    DressModel(name: "One-Shoulder Off Rose Dress", image: "assets/images/dress2.png", price: 99.99, quantity: 1,
      colors: [const Color.fromARGB(255, 255, 106, 106), const Color.fromARGB(255, 64, 224, 70), const Color.fromARGB(255, 62, 75, 255)], ),
    DressModel(name: "Itty Bitty Witchy Dress", image: "assets/images/dress3.png", price: 69.99, quantity: 1,
      colors: [const Color.fromARGB(255, 139, 179, 255), const Color.fromARGB(255, 97, 97, 97), Colors.white, const Color.fromARGB(255, 255, 72, 39)]),
    DressModel(name: "Cocktail Night Dress", image: "assets/images/dress4.png", price: 119.99, quantity: 1,
      colors: [const Color.fromARGB(255, 255, 255, 255), Colors.blue, Colors.purple, const Color.fromARGB(255, 255, 116, 220)],),
    DressModel(name: "Queen Medieval Times Dress", image: "assets/images/dress5.png", price: 74.99, quantity: 1,
      colors: [const Color.fromARGB(255, 91, 255, 228), const Color.fromARGB(255, 239, 247, 127), const Color.fromARGB(255, 255, 147, 147)]),
    DressModel(name: "Trophy Yoga Top", image: "assets/images/top1.png", price: 29.99, quantity: 1,
      colors: [const Color.fromARGB(255, 255, 86, 122), Colors.white, const Color.fromARGB(255, 79, 100, 218)]),
    DressModel(name: "Cozy Christmas Sweater", image: "assets/images/top2.png", price: 44.99, quantity: 1,
      colors: [Colors.red, Colors.blue, Colors.purple],),
    DressModel(name: "Lara Croft Tank Top", image: "assets/images/top3.png", price: 24.99, quantity: 1,
      colors: [const Color.fromARGB(255, 255, 255, 255), const Color.fromARGB(255, 255, 180, 180), const Color.fromARGB(255, 219, 255, 161)]),
    DressModel(name: "Tied Up Crop Top", image: "assets/images/top4.png", price: 14.99, quantity: 1,
      colors: [const Color.fromARGB(255, 24, 78, 114), Colors.white, const Color.fromARGB(255, 255, 51, 51)]),
    DressModel(name: "Buttoned Up Office Shirt", image: "assets/images/top5.png", price: 19.99, quantity: 1,
      colors: [Colors.white, Colors.red, Colors.blue, Colors.purple],),
    DressModel(name: "Belted Short Shorts", image: "assets/images/bottom1.png", price: 24.99, quantity: 1,
      colors: [const Color.fromARGB(255, 75, 255, 171), const Color.fromARGB(255, 255, 146, 73), Colors.white]),
    DressModel(name: "Long Skirt", image: "assets/images/bottom2.png", price: 39.99, quantity: 1,
      colors: [const Color.fromARGB(255, 88, 88, 88), Colors.white, const Color.fromARGB(255, 52, 83, 221)]),
    DressModel(name: "Ripped Skinny Low Rise Jeans", image: "assets/images/bottom3.png", price: 29.99, quantity: 1,
      colors: [const Color.fromARGB(255, 6, 122, 255), const Color.fromARGB(255, 22, 48, 70), Colors.purple],),
    DressModel(name: "Comfy XL Yoga Pants", image: "assets/images/bottom4.png", price: 14.99, quantity: 1,
      colors: [Colors.orange, const Color.fromARGB(255, 255, 35, 171), const Color.fromARGB(255, 23, 218, 23)]),
    DressModel(name: "Y2K Belted Mini Skirt", image: "assets/images/bottom5.png", price: 34.99, quantity: 1,
      colors: [const Color.fromARGB(255, 255, 16, 95), const Color.fromARGB(255, 38, 176, 255), const Color.fromARGB(255, 124, 25, 25)]),
    DressModel(name: "Lovey Butt-Ons Heels", image: "assets/images/shoes1.png", price: 1199.99, quantity: 1,
      colors: [const Color.fromARGB(255, 255, 255, 255), const Color.fromARGB(255, 111, 190, 255), const Color.fromARGB(255, 0, 0, 0)],),
    DressModel(name: "Tight Latex Heelless Shoes", image: "assets/images/shoes2.png", price: 69.99, quantity: 1,
      colors: [const Color.fromARGB(255, 255, 255, 255), const Color.fromARGB(255, 255, 34, 89), const Color.fromARGB(255, 134, 173, 255)]),
    DressModel(name: "Wrapped Around Ankle Sandles", image: "assets/images/shoes3.png", price: 49.99, quantity: 1,
      colors: [const Color.fromARGB(255, 119, 48, 20), Colors.white, const Color.fromARGB(255, 177, 118, 255)]),
    DressModel(name: "High and Chic Heels", image: "assets/images/shoes4.png", price: 59.99, quantity: 1,
      colors: [const Color.fromARGB(255, 189, 37, 26), const Color.fromARGB(255, 48, 48, 48), const Color.fromARGB(255, 255, 255, 255)],),
    DressModel(name: "Autumn Under Knee Boots", image: "assets/images/shoes5.png", price: 44.99, quantity: 1,
      colors: [Colors.white, const Color.fromARGB(255, 129, 80, 7), const Color.fromARGB(255, 85, 193, 255)]),
    //DressModel(name: "Mystery Item", image: "assets/images/surprise.gif", price: 79.99, quantity: 1),
  ];