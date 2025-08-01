import 'package:e_commerce/core/services/shared_prefs_singelton.dart';
import 'package:e_commerce/featchers/AUTH/data/repos/auth_repo.dart';
import 'package:e_commerce/featchers/AUTH/presentation/cubits/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepo) : super(LoginInitial());

  final AuthRepo authRepo;

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());

    // 1️⃣ تسجيل الدخول أولاً باستخدام Auth Service
    final result = await authRepo.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    await result.fold(
      (failure) {
        emit(LoginFailure(failure.message));
      },
      (userEntity) async {
        try {
          // // 2️⃣ تحقق من وجود بيانات المستخدم في Firestore بعد تسجيل الدخول
          // final firestoreUser = await FirebaseFirestore.instance
          //     .collection('users')
          //     .doc(userEntity.uId)
          //     .get();

          // if (!firestoreUser.exists) {
          //   emit(LoginFailure("بيانات المستخدم غير موجودة في قاعدة البيانات"));
          //   return;
          // }

          // 3️⃣ إذا كل شيء تمام
          await Prefs.setBool("isLoggedIn", true);
          await Prefs.setString("userPassword", password);
          emit(LoginSuccess(userEntity: userEntity));
        } catch (e) {
          emit(LoginFailure("خطأ في الوصول إلى قاعدة البيانات"));
        }
      },
    );
  }

  Future<void> signInWithGoogle() async {
    emit(LoginLoading());
    final result = await authRepo.signInWithGoogle();

    result.fold((failure) => emit(LoginFailure(failure.message)), (userEntity) {
      Prefs.setBool("isLoggedIn", true);
      emit(LoginSuccess(userEntity: userEntity));
    });
  }

  Future<void> signInWithFacebook() async {
    emit(LoginLoading());
    final result = await authRepo.signInWithFacebook();

    result.fold((failure) => emit(LoginFailure(failure.message)), (userEntity) {
      Prefs.setBool("isLoggedIn", true); // ✅ أضف هنا كمان
      emit(LoginSuccess(userEntity: userEntity));
    });
  }
}
