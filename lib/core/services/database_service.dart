import 'dart:core';

abstract class DatabaseService {
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    required String documentId,
  });

  Future<dynamic> getData({
    required String path,
    String? docuementId,
    Map<String, dynamic>? query,
  });

  Future<void> setData({
    required String path,
    required String id,
    required Map<String, dynamic> data,
  });

  Future<bool> checkIfDataExists({
    required String documentId,
    required String path,
  });
}
