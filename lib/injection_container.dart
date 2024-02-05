import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:number_trivia/core/network/network_info.dart';
import 'package:number_trivia/core/utils/input_converter.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/repos/number_trivia_repos_impl.dart';
import 'package:number_trivia/features/number_trivia/domain/repos/number_trivia_repos.dart';
import 'package:number_trivia/features/number_trivia/domain/useCases/get_concrete_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/useCases/get_random_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //features

  //bloc
  sl.registerFactory(
    () => NumberTriviaBloc(
      inputConverter: sl(),
      getConcreteNumberTrivia: sl(),
      getRandomNumberTrivia: sl(),
    ),
  );
  //usecases
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));
  //repos
  sl.registerLazySingleton<NumberTriviaRepos>(
    () => NumberTriviaReposImpl(
      networkInfo: sl(),
      numberTriviaLocalDataSource: sl(),
      numberTriviaRemoteDataSources: sl(),
    ),
  );
  //data sources
  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<NumberTriviaRemoteDataSources>(
      () => NumberTriviaRemoteDataSourcesImpl());

  //core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  //external
  // sl.registerLazySingletonAsync(() => SharedPreferences.getInstance());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
