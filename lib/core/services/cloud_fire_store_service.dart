import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/core/services/database_service.dart';

class FireStoreService implements DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    required String documentId,
  }) async {
    await firestore.collection(path).doc(documentId).set(data);
  }

  @override
  Future<Map<String, dynamic>> getData({
    required String path,
    required String documentId,
  }) async {
    final snapshot = await firestore.collection(path).doc(documentId).get();
    return snapshot.data() ?? {};
  }

  @override
  Future<void> setData({
    required String path,
    required String id,
    required Map<String, dynamic> data,
  }) async {
    await firestore.collection(path).doc(id).set(data, SetOptions(merge: true));
  }

  @override
  Future<bool> checkIfDataExists({
    required String documentId,
    required String path,
  }) async {
    final doc = await firestore.collection(path).doc(documentId).get();
    return doc.exists;
  }
}
