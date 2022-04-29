import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul_image/core/network/network_info.dart';
import 'package:soul_image/features/home/data/datasources/local_datacourse.dart';
import 'package:soul_image/features/home/data/datasources/remote_datasource.dart';
import 'package:soul_image/features/home/data/repositories/home_repository_impl.dart';
import 'package:soul_image/features/home/domain/repositories/home_repository.dart';
import 'package:soul_image/features/home/domain/usecases/get_curated_images.dart';
import 'package:soul_image/features/home/presentation/state_manager/home_page_provider.dart';

final locatorService = GetIt.instance;

init() async {
  // Provider
  locatorService.registerFactory(
    () => HomeProvider(locatorService()),
  );

  // UseCases
  locatorService.registerLazySingleton(
    () => GetCuratedImagesUseCase(locatorService()),
  );

  // Repository
  locatorService.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      networkInfo: locatorService(),
      homeRemoteDatasource: locatorService(),
      homeLocalDataSource: locatorService(),
    ),
  );

  locatorService.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(),
  );

  locatorService.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(sharedPreferences: locatorService()),
  );

  // Core
  locatorService.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(locatorService()),
  );

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  locatorService.registerLazySingleton(() => sharedPreferences);
  locatorService.registerLazySingleton(() => InternetConnectionChecker());
}
