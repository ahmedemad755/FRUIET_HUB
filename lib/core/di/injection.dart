import 'package:get_it/get_it.dart';
import 'package:e_commerce/core/services/cloud_fire_store_service.dart';
import 'package:e_commerce/core/services/database_service.dart';
import 'package:e_commerce/core/services/firebase_auth_service.dart';
import 'package:e_commerce/featchers/auth/data/repos/auth_repo.dart';
import 'package:e_commerce/featchers/auth/data/repos/auth_repo_impl.dart';
import 'package:e_commerce/featchers/auth/presentation/cubits/login/login_cubit.dart';
import 'package:e_commerce/featchers/auth/presentation/cubits/signup/sugnup_cubit.dart';
import 'package:e_commerce/featchers/auth/presentation/cubits/vereficationotp/vereficationotp_cubit.dart';

final getIt = GetIt.instance;

void setupGetit() {
  // 1. تسجيل الخدمات الأساسية
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());

  // 2. تسجيل FireStoreService مره واحده و تربطه كمان بـ Databaseservice
  final fireStoreService = FireStoreService();
  getIt.registerSingleton<FireStoreService>(fireStoreService);
  getIt.registerSingleton<Databaseservice>(fireStoreService);

  // 3. تسجيل AuthRepo
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(
      firebaseAuthService: getIt<FirebaseAuthService>(),
      databaseservice: getIt<Databaseservice>(),
      fireStoreService: getIt<FireStoreService>(),
    ),
  );

  // 4. باقي الـ Cubits
  getIt.registerSingleton<AuthRepoImpl>(getIt<AuthRepo>() as AuthRepoImpl);
  getIt.registerFactory<SugnupCubit>(() => SugnupCubit(getIt()));
  getIt.registerSingleton<LoginCubit>(LoginCubit(getIt()));
  getIt.registerFactory<OTPCubit>(() => OTPCubit(getIt()));
}
