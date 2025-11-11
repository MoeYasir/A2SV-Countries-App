import 'package:a2sv_project/data/datasources/remote/country_remote_data_source.dart';
import 'package:a2sv_project/data/datasources/remote/country_remote_data_source_impl.dart';
import 'package:a2sv_project/data/repositories/country_repository.dart';
import 'package:a2sv_project/data/repositories/country_repository_impl.dart';
import 'package:a2sv_project/presentation/home/cubit/home_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setup() {
  sl.registerSingleton<Dio>(Dio());

  sl.registerLazySingleton<CountryRemoteDataSource>(
    () => CountryRemoteDataSourceImpl(dio: sl()),
  );

  sl.registerLazySingleton<CountryRepository>(
    () => CountryRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerFactory(() => HomeCubit(sl()));
}
