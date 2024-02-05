import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/errors/exceptions.dart';
import 'package:number_trivia/core/network/network_info.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entites/number_trivia.dart';
import '../../domain/repos/number_trivia_repos.dart';

typedef GetconcreteOrRandomChooser = Future<NumberTriviaModel> Function();

class NumberTriviaReposImpl implements NumberTriviaRepos {
  final NetworkInfo networkInfo;
  final NumberTriviaLocalDataSource numberTriviaLocalDataSource;
  final NumberTriviaRemoteDataSources numberTriviaRemoteDataSources;

  NumberTriviaReposImpl(
      {required this.networkInfo,
      required this.numberTriviaLocalDataSource,
      required this.numberTriviaRemoteDataSources});
  @override
  Future<Either<Failures, NumberTrivia>> getConcreteNumber(int num) async {
    return await _getTrivia(
        () => numberTriviaRemoteDataSources.getConcreteNumberTrivia(num));
  }

  @override
  Future<Either<Failures, NumberTrivia>> getRandomNumber() async {
    return await _getTrivia(
        () => numberTriviaRemoteDataSources.getRandomNumberTrivia());
  }

  Future<Either<Failures, NumberTrivia>> _getTrivia(
      GetconcreteOrRandomChooser getconcreteOrRandom) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getconcreteOrRandom();
        await numberTriviaLocalDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localNumberTrivia =
            await numberTriviaLocalDataSource.getlastNumberTrivia();
        return Right(localNumberTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
