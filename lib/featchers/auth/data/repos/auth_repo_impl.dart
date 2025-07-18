import 'dart:developer' as developer;

import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/errors/exceptions.dart';
import 'package:e_commerce/core/errors/faliur.dart';
import 'package:e_commerce/core/services/firebase_auth_service.dart';
import 'package:e_commerce/featchers/auth/data/models/user_model.dart';
import 'package:e_commerce/featchers/auth/data/repos/auth_repo.dart';
import 'package:e_commerce/featchers/auth/domain/entites/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl extends AuthRepo {
  final FirebaseAuthService firebaseAuthService;

  AuthRepoImpl({required this.firebaseAuthService});
  @override
  Future<Either<Faliur, UserEntity>> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final user = await firebaseAuthService.creatuserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(UserModel.fromfirebaseUser(user)); // التحويل إلى UserEntity
    } on CustomException catch (e) {
      return Left(ServerFaliur(e.message));
    } catch (e) {
      throw CustomException(
        message: 'Failed to create user with email and password',
      );
    }
  }

  @override
  Future<Either<Faliur, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await firebaseAuthService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(UserModel.fromfirebaseUser(user)); // التحويل إلى UserEntity
    } on CustomException catch (e) {
      return Left(ServerFaliur(e.message));
    } catch (e) {
      developer.log(
        'Exception in AuthRepoImpl.createUserWithEmailAndPassword: ${e.toString()}',
      );
      return Left(ServerFaliur('حدث خطأ ما. الرجاء المحاولة مرة اخرى.'));
    }
  }

  @override
  Future<Either<Faliur, UserEntity>> signInWithGoogle() async {
    try {
      final userCredential = await firebaseAuthService.signInWithGoogle();
      final user = userCredential.user;

      if (user == null) {
        return Left(ServerFaliur('فشل تسجيل الدخول بحساب Google.'));
      }

      return Right(UserModel.fromfirebaseUser(user));
    } on CustomException catch (e) {
      return Left(ServerFaliur(e.message));
    } catch (e) {
      developer.log(
        'Exception in AuthRepoImpl.signInWithGoogle: ${e.toString()}',
      );
      return Left(ServerFaliur('حدث خطأ ما. الرجاء المحاولة مرة أخرى.'));
    }
  }

  // @override
  // Future<Either<Faliur, UserEntity>> signInWithGoogle() async {
  //   try {
  //     // 1. Sign in with Google
  //     final user = await firebaseAuthService.signInWithGoogle();

  //     // 2. Convert Firebase User to UserModel/UserEntity
  //     return Right(UserModel.fromfirebaseUser(user));
  //   } on CustomException catch (e) {
  //     return Left(ServerFaliur(e.message));
  //   } catch (e) {
  //     developer.log(
  //       'Exception in AuthRepoImpl.signInWithGoogle: ${e.toString()}',
  //     );
  //     return Left(ServerFaliur('حدث خطأ أثناء تسجيل الدخول باستخدام جوجل'));
  //   }
  // }

  // @override
  // Future<Either<Faliur, UserEntity>> signInWithApple() {
  //   throw UnimplementedError();
  // }

  // @override
  // Future<Either<Faliur, UserEntity>> signInWithFacebook() {
  //   // TODO: implement signInWithFacebook
  //   throw UnimplementedError();
  // }

  // @override
  // Future<Either<Faliur, UserEntity>> signInWithFacebook() async {
  //   try {
  //     // 1. Trigger Facebook Sign-In flow
  //     final result = await FacebookAuth.instance.login();

  //     if (result.status == LoginStatus.success) {
  //       // 2. Get user data
  //       final userData = await FacebookAuth.instance.getUserData();

  //       return Right(user);
  //     } else {
  //       return Left(ServerFaliur('Failed to sign in with Facebook'));
  //     }
  //   } catch (e) {
  //     developer.log(
  //       'Exception in AuthRepoImpl.signInWithFacebook: ${e.toString()}',
  //     );
  //     return Left(ServerFaliur('حدث خطأ أثناء تسجيل الدخول باستخدام فيسبوك'));
  //   }
  // }
}
