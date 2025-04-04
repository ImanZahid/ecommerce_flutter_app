import '../firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;

class FirebaseManager {
  late final FirebaseFirestore firebaseFirestore;
  FirebaseManager();

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    );
  }

  Future<void> initalizeFirebaseFirestore() async {
    firebaseFirestore = FirebaseFirestore.instance;
  }
}