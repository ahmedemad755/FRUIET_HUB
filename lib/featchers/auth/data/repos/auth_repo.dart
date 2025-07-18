import 'package:dartz/dartz.dart'; // Add this import// Corrected typo
import 'package:e_commerce/core/errors/faliur.dart';
import 'package:e_commerce/featchers/auth/domain/entites/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Faliur, UserEntity>> createUserWithEmailAndPassword({
    // Corrected typo
    required String email,
    required String password,
    required String name,
  });

  Future<Either<Faliur, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  //  Google Sign-In method
  Future<Either<Faliur, UserEntity>> signInWithGoogle();

  // Facebook Sign-In method
  Future<Either<Faliur, UserEntity>> signInWithFacebook();

  // // Apple Sign-In method
  // Future<Either<Faliur, UserEntity>> signInWithApple();
}
