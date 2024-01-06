import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/auth/auth_data_source/auth_remote_data_source.dart';
import '../data/auth/auth_repo/auth_repository.dart';
import '../data/coach/coach_data_source/coach_remote_data_source.dart';
import '../data/coach/coach_repo/coach_repository.dart';
import '../data/coach_app/coach_app_data_source/coach_app_remote_data_source.dart';
import '../data/coach_app/coach_app_repo/coach_app_repository.dart';
import '../data/core/api_helper/app_api_helper.dart';
import '../data/core/api_helper/app_api_helper_Impl.dart';
import '../data/core/utils/dio_factory.dart';
import '../data/core/utils/network/network_info.dart';
import '../data/home/home_data_source/home_remote_data_source.dart';
import '../data/home/home_repo/home_repository.dart';
import '../data/profile/profile_data_source/profile_remote_data_source.dart';
import '../data/profile/profile_repo/profile_repository.dart';
import '../domain/core/utils/network/network_info.dart';
import '../presentation/trainee/main_bottom_navigation_bar/getx/main_bottom_navigation_bar_controller.dart';
import 'app_controller.dart';
import 'storage/app_prefs.dart';

final instance = GetIt.instance;

///
/// The [init] function is responsible for adding the instances to the graph
///
Future<void> init() async {
  //! External

  /// Adding the [SharedPreferences] instance to the graph to be later used by the local data sources
  final sharedPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  /// network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  /// pass dio Creating[AppServiceClient] class
  // instance.registerLazySingleton<AppService>(() => AppServiceClient(instance()));
  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));
  // Data sources
  Dio dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppApiHelper>(() => AppApiHelperImpl(dio));

  Get.put(AppController(), permanent: true);
  Get.put(MainBottomNavigationBarController());

  initAuthModule();
  initProfileModule();
  initHomeModule();
  initCoachModule();
  initCoachAppModule();
}

initAuthModule() {
  if (!instance.isRegistered<BaseAuthRemoteDataSource>()) {
    instance.registerFactory<BaseAuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(instance<AppApiHelper>()));
  }
  if (!instance.isRegistered<BaseAuthRepository>()) {
    instance.registerFactory<BaseAuthRepository>(
      () => AuthRepositoryImpl(
        instance(),
        instance(),
      ),
    );
  }
}

initProfileModule() {
  if (!instance.isRegistered<BaseProfileRemoteDataSource>()) {
    instance.registerFactory<BaseProfileRemoteDataSource>(
        () => ProfileRemoteDataSourceImpl(instance<AppApiHelper>()));
  }
  if (!instance.isRegistered<BaseProfileRepository>()) {
    instance.registerFactory<BaseProfileRepository>(
      () => ProfileRepositoryImpl(
        instance(),
        instance(),
      ),
    );
  }
}

initHomeModule() {
  if (!instance.isRegistered<BaseHomeRemoteDataSource>()) {
    instance.registerFactory<BaseHomeRemoteDataSource>(
        () => HomeRemoteDataSourceImpl(instance<AppApiHelper>()));
  }
  if (!instance.isRegistered<BaseHomeRepository>()) {
    instance.registerFactory<BaseHomeRepository>(
      () => HomeRepositoryImpl(
        instance(),
        instance(),
      ),
    );
  }
}

initCoachModule() {
  if (!instance.isRegistered<BaseCoachRemoteDataSource>()) {
    instance.registerFactory<BaseCoachRemoteDataSource>(
        () => CoachRemoteDataSourceImpl(instance<AppApiHelper>()));
  }
  if (!instance.isRegistered<BaseCoachRepository>()) {
    instance.registerFactory<BaseCoachRepository>(
      () => CoachRepositoryImpl(
        instance(),
        instance(),
      ),
    );
  }
}

initCoachAppModule() {
  if (!instance.isRegistered<BaseCoachAppRemoteDataSource>()) {
    instance.registerFactory<BaseCoachAppRemoteDataSource>(
        () => CoachAppRemoteDataSourceImpl(instance<AppApiHelper>()));
  }
  if (!instance.isRegistered<BaseCoachAppRepository>()) {
    instance.registerFactory<BaseCoachAppRepository>(
      () => CoachAppRepositoryImpl(
        instance(),
        instance(),
      ),
    );
  }
}
