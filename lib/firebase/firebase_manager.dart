import '../firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseManager {
  static final FirebaseManager _instance = FirebaseManager._internal();
  factory FirebaseManager() => _instance;
  FirebaseManager._internal();

  FirebaseFirestore? _firestore;
  FirebaseAuth? _auth;

  FirebaseFirestore get firestore => _firestore!;
  FirebaseAuth get auth => _auth!;

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    _firestore = FirebaseFirestore.instance;
    _auth = FirebaseAuth.instance;
    _initialized = true;
  }
}
