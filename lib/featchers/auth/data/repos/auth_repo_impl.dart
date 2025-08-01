import 'dart:developer' as developer;
import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/errors/exceptions.dart';
import 'package:e_commerce/core/errors/faliur.dart';
import 'package:e_commerce/core/services/cloud_fire_store_service.dart';
import 'package:e_commerce/core/services/database_service.dart';
import 'package:e_commerce/core/services/firebase_auth_service.dart';
import 'package:e_commerce/core/utils/backend_points.dart';
import 'package:e_commerce/featchers/AUTH/data/models/user_model.dart';
import 'package:e_commerce/featchers/AUTH/data/repos/auth_repo.dart';
import 'package:e_commerce/featchers/AUTH/domain/entites/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl extends AuthRepo {
  final FirebaseAuthService firebaseAuthService;
  final Databaseservice databaseservice;
  final FireStoreService fireStoreService;

  AuthRepoImpl({
    required this.databaseservice,
    required this.firebaseAuthService,
    required this.fireStoreService,
  });
  @override
  Future<Either<Faliur, UserEntity>> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String role,
    // required String cardImageUrl,
  }) async {
    User? user;
    try {
      //انشاء اكونت
      user = await firebaseAuthService.creatuserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var userentity = UserEntity(
        email: email,
        name: name,
        uId: user.uid,
        role: role,

        // cardImageUrl: cardImageUrl,
      );

      // اضافة البيانات الى الداتا بيز
      await addUserData(user: userentity, email: email);

      //ارجع بردو المستخدم
      return Right(userentity);
    } on CustomException catch (e) {
      await deletUser(user);

      return Left(ServerFaliur(e.message));
    } catch (e) {
      await deletUser(user);
      throw CustomException(
        message: 'Failed to create user with email and password',
      );
    }
  }

  Future<void> deletUser(User? user) async {
    if (user != null) {
      await firebaseAuthService.deleteUser();
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
      var userentity = await getUserData(Uid: user.uid);
      return Right(userentity); // التحويل إلى UserEntity
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
    User? user;
    try {
      final userCredential = await firebaseAuthService.signInWithGoogle();
      user = userCredential.user;
      var userentity = UserModel.fromfirebaseUser(user!);
      var isuserexist = await databaseservice.checkIfDataExists(
        documentId: user.uid,
        path: BackendPoints.isUserexist,
      );
      if (isuserexist) {
        await getUserData(Uid: user.uid);
      } else {
        await addUserData(user: userentity, useSet: true, email: user.email!);
      }

      // if (user == null) {
      //   return Left(ServerFaliur(' .فشل تسجيل الدخول بحساب Google.'));
      // }

      return Right(userentity);
    } on CustomException catch (e) {
      return Left(ServerFaliur(e.message));
    } catch (e) {
      await deletUser(user);
      developer.log(
        'Exception in AuthRepoImpl.signInWithGoogle: ${e.toString()}',
      );
      return Left(
        ServerFaliur('حدث خطأ ما. الرجاء المحاولة مرة أخرى.${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Faliur, UserEntity>> signInWithFacebook() async {
    User? user;
    try {
      final userCredential = await firebaseAuthService.signInWithFacebook();
      user = userCredential.user;
      var userentity = UserModel.fromfirebaseUser(user!);
      await addUserData(user: userentity, email: user.email!);

      // if (userentity == null) {
      //   return Left(ServerFaliur('Failed to sign in with Facebook'));
      // }
      return Right(userentity);
    } on CustomException catch (e) {
      await deletUser(user);
      return Left(ServerFaliur(e.message));
    } catch (e) {
      await deletUser(user);
      developer.log(
        'Exception in AuthRepoImpl.signInWithFacebook: ${e.toString()}',
      );
      return Left(ServerFaliur('حدث خطاء ما. الرجاء المحاولة مرة اخرى.'));
    }
  }

  @override
  Future addUserData({
    required UserEntity user,
    bool useSet = false,
    required String email,
  }) async {
    if (useSet) {
      await databaseservice.setData(
        path: BackendPoints.addUserData,
        id: user.uId,
        data: user.toMap(),
      );
    } else {
      await databaseservice.addData(
        path: BackendPoints.addUserData,
        data: user.toMap(),
        documentId: user.uId,
      );
    }
  }

  @override
  Future<UserEntity> getUserData({required String Uid}) async {
    var userData = await databaseservice.getData(
      path: BackendPoints.getUserData,
      DcumentId: Uid,
    );
    return UserModel.fromJson(userData);
  }

  @override
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required void Function(String verificationId) onCodeSent,
    required void Function(FirebaseAuthException error) onVerificationFailed,
    required void Function(PhoneAuthCredential credential)
    onVerificationCompleted,
    required void Function(String verificationId) onAutoRetrievalTimeout,
  }) async {
    await firebaseAuthService.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      onCodeSent: onCodeSent,
      onVerificationFailed: onVerificationFailed,
      onVerificationCompleted: onVerificationCompleted,
      onAutoRetrievalTimeout: onAutoRetrievalTimeout,
    );
  }

  @override
  Future<UserCredential> verifySmsCode(String smsCode) async {
    return await firebaseAuthService.verifySmsCode(smsCode);
  }

  // @override
  // User? getCurrentUser() {
  //   return FirebaseAuth.instance.currentUser;
  // }
}
