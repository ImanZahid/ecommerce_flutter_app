import 'package:flutter/material.dart';
import 'package:ecommerce_flutter_app/pages/shopping/dress_shop_page.dart';

void main() {
  runApp(const DressShopApp());
}

class DressShopApp extends StatelessWidget {
  const DressShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dress Shop',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),

      //TODO - use routes, instaed of this, but since for the time being we only have this page, im adding it here
      home: DressShopPage(),
    );
  }
}
