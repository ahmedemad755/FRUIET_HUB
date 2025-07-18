import 'package:bloc/bloc.dart';
import 'package:e_commerce/featchers/auth/data/repos/auth_repo.dart';
import 'package:e_commerce/featchers/auth/domain/entites/user_entity.dart';
import 'package:equatable/equatable.dart';

part 'sugnup_state.dart';

class SugnupCubit extends Cubit<SugnupState> {
  final AuthRepo authRepo;

  SugnupCubit(this.authRepo) : super(SugnupInitial());

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(SugnupLoading());

    final result = await authRepo.createUserWithEmailAndPassword(
      email: email,
      password: password,
      name: name,
    );

    result.fold(
      (failure) => emit(SugnupFailure(failure.message)),
      (userEntity) => emit(
        SugnupSuccess(
          userEntity: userEntity,
          successMessage: 'مرحباً ${userEntity.name}! تم تسجيلك بنجاح',
        ),
      ),
    );
  }
}
