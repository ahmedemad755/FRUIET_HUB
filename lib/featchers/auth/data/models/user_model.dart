import 'package:e_commerce/featchers/auth/domain/entites/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.email,
    required super.password,
    required super.name,
    required super.uId,
  });

  factory UserModel.fromfirebaseUser(User user) {
    return UserModel(
      email: user.email ?? "",
      name: user.displayName ?? '',
      uId: user.uid,
      password: '',
    );
  }
}
