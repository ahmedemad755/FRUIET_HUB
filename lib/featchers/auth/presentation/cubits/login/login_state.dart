import 'package:e_commerce/featchers/auth/domain/entites/user_entity.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {
  final UserEntity userEntity; // اسم المتغير هنا 'user' وليس 'userEntity'

  // Constructor صحيح مع named parameter
  const LoginSuccess({required this.userEntity});
}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {
  final String message;

  const LoginFailure(this.message);
}
