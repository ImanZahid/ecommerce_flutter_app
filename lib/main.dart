import 'package:ecommerce_flutter_app/firebase/firebase_manager.dart';
import 'package:ecommerce_flutter_app/sqlite/sqlite_manager.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_flutter_app/pages/shopping/dress_shop_page.dart';
import 'package:ecommerce_flutter_app/pages/auth/register_page.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'platform_check.dart'; // only this for platform detection


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (isDesktop) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  await FirebaseManager().initialize();


  try {
    print("Seeding database...");
    await DatabaseHelper().seedInitialData();
    print("Seeding complete.");
  } catch (e) {
    print("Error while seeding DB: $e");
  }

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
      initialRoute: '/register',
      routes: {
        '/register': (context) => const RegisterPage(),
        '/shop': (context) => DressShopPage(),
      },
    );
  }
}
