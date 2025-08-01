import 'package:dartz/dartz.dart'; // Add this import// Corrected typo
import 'package:e_commerce/core/errors/faliur.dart';
import 'package:e_commerce/featchers/auth/domain/entites/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepo {
  Future<Either<Faliur, UserEntity>> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String role,
  });

  Future<Either<Faliur, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  //  Google Sign-In method
  Future<Either<Faliur, UserEntity>> signInWithGoogle();

  // Facebook Sign-In method
  Future<Either<Faliur, UserEntity>> signInWithFacebook();

  Future addUserData({
    required UserEntity user,
    bool useSet = false,
    required String email,
  });

  Future<UserEntity> getUserData({required String Uid});

  // // Apple Sign-In method
  // Future<Either<Faliur, UserEntity>> signInWithApple();

  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required void Function(String verificationId) onCodeSent,
    required void Function(FirebaseAuthException error) onVerificationFailed,
    required void Function(PhoneAuthCredential credential)
    onVerificationCompleted,
    required void Function(String verificationId) onAutoRetrievalTimeout,
  });

  Future<UserCredential> verifySmsCode(String smsCode);
}
