import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:uber/core/utility/app_prefs.dart';
import 'package:uber/data/data_sources/remote/api/google_map_apis.dart';
import 'package:uber/data/data_sources/remote/api/google_map_apis_manual.dart';
import 'package:uber/data/repositories_impl/firebase_auth_repo_impl.dart';
import 'package:uber/data/repositories_impl/google_map_apis_repo_impl.dart';
import 'package:uber/data/repositories_impl/personal_info_repo_impl.dart';
import 'package:uber/domain/repositories/auth_repository.dart';
import 'package:uber/domain/repositories/google_map_apis_repo.dart';
import 'package:uber/domain/repositories/personal_info_repository.dart';
import 'package:uber/presentation/cubit/firebaseAuthCubit/firebase_auth_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uber/presentation/cubit/google_map_cubit/places_suggestions_cubit.dart';
import 'package:uber/presentation/cubit/personal_info_cubit/personal_info_cubit_cubit.dart';

final injector = GetIt.I;

Future<void> initializeDependencies() async {
  // shared prefs instance
  final sharedPrefs = await SharedPreferences.getInstance();

  // shared prefs instance
  injector.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance
  injector
      .registerLazySingleton<AppPreferences>(() => AppPreferences(injector()));

  /// =============================== Data source =========================================>

  injector.registerLazySingleton<GoogleMapAPIs>(
      () => GoogleMapAPIs(createAndSetupDio()));

  injector.registerLazySingleton<GoogleMapAPIsManual>(
      () => GoogleMapAPIsManual(createAndSetupDio()));

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

  // personal info Repository
  injector.registerLazySingleton<GoogleMapAPIsRepo>(
    () => GoogleMapAPIsRepoImpl(injector(), injector()),
  );
  // *
  /// ================================ Blocs ========================================>

  // auth cubit
  injector.registerFactory<FirebaseAuthCubit>(
    () => FirebaseAuthCubit(injector()),
  );

  // personal info cubit
  injector.registerFactory<PersonalInfoCubitCubit>(
    () => PersonalInfoCubitCubit(injector()),
  );
  // *

  // Places suggestions cubit
  injector.registerFactory<GoogleMapCubit>(
    () => GoogleMapCubit(injector()),
  );
  // *
}

Dio createAndSetupDio() {
  Dio dio = Dio();

  dio
    ..options.connectTimeout = 200 * 1000
    ..options.receiveTimeout = 200 * 1000;

  dio.interceptors.add(LogInterceptor(
    responseBody: true,
    error: true,
    requestHeader: false,
    responseHeader: false,
    request: true,
    requestBody: true,

  ));

  return dio;
}
