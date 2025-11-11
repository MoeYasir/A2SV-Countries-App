import 'package:a2sv_project/data/datasources/local/country_local_data_source_impl.dart';
import 'package:a2sv_project/data/datasources/local/country_local_data_sources.dart';
import 'package:a2sv_project/data/datasources/remote/country_remote_data_source.dart';
import 'package:a2sv_project/data/datasources/remote/country_remote_data_source_impl.dart';
import 'package:a2sv_project/data/repositories/country_repository.dart';
import 'package:a2sv_project/data/repositories/country_repository_impl.dart';
import 'package:a2sv_project/presentation/country_detail/cubit/country_detail_cubit.dart';
import 'package:a2sv_project/presentation/favourites/cubit/favourites_cubit.dart';
import 'package:a2sv_project/presentation/home/cubit/home_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

final sl = GetIt.instance;

void setup() async {
  sl.registerSingleton<Dio>(Dio());
  sl.registerFactory(() => HomeCubit(sl()));
  sl.registerFactory(() => CountryDetailCubit(sl()));
  sl.registerFactory(() => FavoritesCubit(sl()));
  sl.registerLazySingleton<Box<String>>(() => Hive.box<String>('favourites'));
  sl.registerLazySingleton<CountryRemoteDataSource>(
    () => CountryRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<CountryRepository>(
    () => CountryRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );
  sl.registerLazySingleton<CountryLocalDataSource>(
    () => CountryLocalDataSourceImpl(sl()),
  );
}
