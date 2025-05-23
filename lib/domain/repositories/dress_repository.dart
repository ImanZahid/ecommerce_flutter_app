import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_flutter_app/domain/exceptions/firebase_document_exception.dart';
import 'package:ecommerce_flutter_app/domain/shopping/dress_model.dart';

class DressRepository {
  final FirebaseFirestore firebaseFirestore;
  DressRepository({required this.firebaseFirestore});

  Future<DressModel> getDress(String dressId) async {
     final DocumentSnapshot dress = await firebaseFirestore.collection('dresses').doc(dressId).get();
     if (!dress.exists) {
        throw FirebaseDocumentNotFound('Dress with the dressId $dressId not found!');
     }
      return DressModel.fromMap(dress.data()! as Map<String, dynamic>);
  }

  Future<List<DressModel>> getDresses() async {
     final QuerySnapshot<Map<String, dynamic>> dresses = await firebaseFirestore.collection('dresses').get();
     List<DressModel> dressModels = dresses.docs.map((dress) => DressModel.fromMap(dress.data())).toList();
      return dressModels;
  }

  Future<void> createDress(DressModel dress) async {
    Object dressObject = dress.toMap();
    await firebaseFirestore.collection('dresses').add(dressObject as Map<String, dynamic>);
  }

  Future<void> updateStock(List<DressModel> dresses) async {
    for(int i=0; i< dresses.length; i++) {
      Object dressObject = dresses[i].toMap();
      await firebaseFirestore.collection('dresses').add(dressObject as Map<String, dynamic>);
    }
  }
}
