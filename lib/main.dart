import 'package:flutter/material.dart';
import 'package:ecommerce_flutter_app/pages/shopping/dress_shop_page.dart';
import 'package:ecommerce_flutter_app/pages/auth/register_page.dart'; // Import the register page

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
      theme: ThemeData(primarySwatch: Colors.pink),
      // Set the register page as the initial route
      initialRoute: '/register',
      routes: {
        '/register': (context) => const RegisterPage(),
        '/shop': (context) => DressShopPage(),
      },
    );
  }
}
