import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_flutter_app/domain/exceptions/firebase_document_exception.dart';
import 'package:ecommerce_flutter_app/domain/user/user_model.dart';

class UserRepository {
  final FirebaseFirestore firebaseFirestore;
  UserRepository({required this.firebaseFirestore});

  Future<UserModel> getUser(String userId) async {
     final DocumentSnapshot user = await firebaseFirestore.collection('users').doc(userId).get();
     if (!user.exists) {
        throw FirebaseDocumentNotFound('User with the userId $userId not found!');
     }
      return UserModel.fromMap(user.data()! as Map<String, dynamic>);
  }

  Future<List<UserModel>> getUsers () async {
    final QuerySnapshot<Map<String, dynamic>> users = await firebaseFirestore.collection('users').get();
    return users.docs.map((doc) => {
      UserModel.fromMap(doc.data())
    }).toList() as List<UserModel>;
  }

  Future<void> createUser(UserModel user) async {
    Object userObject = user.toMap();
    await firebaseFirestore.collection('users').add(userObject as Map<String, dynamic>);
  }
  
}
