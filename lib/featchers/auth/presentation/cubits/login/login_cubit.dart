import 'package:e_commerce/core/services/shared_prefs_singelton.dart';
import 'package:e_commerce/featchers/auth/data/repos/auth_repo.dart';
import 'package:e_commerce/featchers/auth/presentation/cubits/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepo) : super(LoginInitial());

  final AuthRepo authRepo;
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    final result = await authRepo.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    result.fold((failure) => emit(LoginFailure(failure.message)), (userEntity) {
      Prefs.setBool("isLoggedIn", true);
      emit(LoginSuccess(userEntity: userEntity));
    });
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
