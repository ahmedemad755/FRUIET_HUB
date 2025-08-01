import 'package:e_commerce/featchers/auth/domain/entites/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.email,
    // required super.password,
    required super.name,
    required super.uId,
    required super.role,

    // required super.cardImageUrl,
  });

  factory UserModel.fromfirebaseUser(User user) {
    return UserModel(
      email: user.email ?? "",
      name: user.displayName ?? '',
      uId: user.uid,
      role: '',

      // cardImageUrl: user.photoURL ?? '',
      // password: '',
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      uId: map['uId'] ?? '',
      role: map['role'] ?? '',
      // cardImageUrl: map['cardImageUrl'] ?? '',
      // password: map['password'] ?? '',
    );
  }
}
