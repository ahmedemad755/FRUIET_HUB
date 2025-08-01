import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/core/services/database_service.dart';

class FireStoreService implements Databaseservice {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  }) async {
    if (documentId != null) {
      await firestore.collection(path).doc(documentId).set(data);
    } else {
      await firestore.collection(path).add(data);
    }
  }

  @override
  Future<void> setData({
    required String path,
    required String id,
    required Map<String, dynamic> data,
  }) async {
    await firestore
        .collection(path)
        .doc(id)
        .set(
          data,
          SetOptions(merge: true), // دمج البيانات لو كانت موجودة
        );
  }

  @override
  Future<Map<String, dynamic>> getData({
    required String path,
    required String DcumentId,
  }) async {
    var data = await firestore.collection(path).doc(DcumentId).get();
    return data.data() as Map<String, dynamic>;
  }

  @override
  Future<bool> checkIfDataExists({
    required String documentId,
    required String path,
  }) async {
    var data = await firestore.collection(path).doc(documentId).get();
    return data.exists;
  }
}
