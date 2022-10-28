import 'package:get_it/get_it.dart';
import 'package:uber/data/repositories_impl/firebase_auth_repo_impl.dart';
import 'package:uber/data/repositories_impl/personal_info_repo_impl.dart';
import 'package:uber/domain/repositories/auth_repository.dart';
import 'package:uber/domain/repositories/personal_info_repository.dart';
import 'package:uber/domain/use_cases/auth/log_out.dart';
import 'package:uber/domain/use_cases/auth/submit_otp.dart';
import 'package:uber/domain/use_cases/auth/submit_phone_umber.dart';
import 'package:uber/domain/use_cases/personal_info/create_new_user.dart';
import 'package:uber/domain/use_cases/personal_info/get_user_info.dart';
import 'package:uber/presentation/cubit/firebaseAuthCubit/firebase_auth_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uber/presentation/cubit/personal_info_cubit/personal_info_cubit_cubit.dart';

final injector = GetIt.I;

Future<void> initializeDependencies() async {
  // shared prefs instance
  final sharedPrefs = await SharedPreferences.getInstance();

  injector.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  /// =============================== Repository =========================================>

  // Firebase Auth Repository

  injector.registerLazySingleton<FirebaseAuthRepository>(
    () => FirebaseAuthRepositoryImpl(),
  );

  // personal info Repository
  injector.registerLazySingleton<PersonalInfoRepository>(
        () => PersonalInfoRepoImpl(),
  );
  // *
  /// =============================== useCases =========================================>

  // Firebase auth useCases
  injector.registerLazySingleton<VerifyMobilePhoneUseCase>(
      () => VerifyMobilePhoneUseCase(injector()));
  injector
      .registerLazySingleton<LogOutUseCase>(() => LogOutUseCase(injector()));

  injector.registerLazySingleton<SubmitOtpPhoneUseCase>(
      () => SubmitOtpPhoneUseCase(injector()));

  // personal info useCases
  injector.registerLazySingleton<GetUserInfoUseCase>(
          () => GetUserInfoUseCase(injector()));

  injector.registerLazySingleton<CreateUserUseCase>(
          () => CreateUserUseCase(injector()));

  /// ================================ Blocs ========================================>

  // auth Blocs
  injector.registerFactory<FirebaseAuthCubit>(
    () => FirebaseAuthCubit(injector(), injector(), injector()),
  );

  // personal info Blocs
  injector.registerFactory<PersonalInfoCubitCubit>(
        () => PersonalInfoCubitCubit( injector(), injector()),
  );
  // *
}
