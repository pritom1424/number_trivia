import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entites/number_trivia.dart';

abstract class NumberTriviaRepos {
  Future<Either<Failures, NumberTrivia>> getConcreteNumber(int num);
  Future<Either<Failures, NumberTrivia>> getRandomNumber();
}
