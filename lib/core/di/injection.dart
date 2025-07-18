import 'package:e_commerce/core/services/firebase_auth_service.dart';
import 'package:e_commerce/featchers/auth/data/repos/auth_repo.dart';
import 'package:e_commerce/featchers/auth/data/repos/auth_repo_impl.dart';
import 'package:e_commerce/featchers/auth/presentation/cubits/login/login_cubit.dart';
import 'package:e_commerce/featchers/auth/presentation/cubits/sugnup/sugnup_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetit() {
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  // getIt.registerSingleton<DatabaseService>(FireStoreService());
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(
      firebaseAuthService: getIt<FirebaseAuthService>(),
      // databaseService: getIt<DatabaseService>(),
    ),
  );
  getIt.registerFactory<SugnupCubit>(() => SugnupCubit(getIt()));
  getIt.registerSingleton<LoginCubit>(LoginCubit(getIt()));

  // getIt.registerSingleton<ProductsRepo>(
  //   ProductsRepoImpl(getIt<DatabaseService>()),
  // );

  // getIt.registerSingleton<OrdersRepo>(
  //   OrdersRepoImpl(
  //     getIt<DatabaseService>(),
  //   ),
  // );
}
