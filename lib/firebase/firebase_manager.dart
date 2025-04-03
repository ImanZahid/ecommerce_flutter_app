import '../firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseManager {
  FirebaseManager();

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    );
  }
}