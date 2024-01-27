import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entites/number_trivia.dart';

abstract class NumberTriviaRepos {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int? number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
