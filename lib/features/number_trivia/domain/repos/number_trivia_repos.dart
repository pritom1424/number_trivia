import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/errors/failures.dart';
import 'package:number_trivia/features/number_trivia/domain/entites/number_trivia.dart';

abstract class NumberTriviaRepos {
  Future<Either<Failures, NumberTrivia>> getConcreteNumber(int num);
  Future<Either<Failures, NumberTrivia>> getRandomNumber();
}
