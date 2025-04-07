import 'package:ecommerce_flutter_app/firebase/firebase_manager.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_flutter_app/pages/shopping/dress_shop_page.dart';
import 'package:ecommerce_flutter_app/pages/auth/register_page.dart'; // Import the register page

void main() async {
  //this is needed first (because runApp runs letter, and that binds all the assets, and bindings are called before - because in the firebase manager class we call currentPlatform)
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseManager firebaseManager = FirebaseManager();
  await firebaseManager.initializeFirebase();
  
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
