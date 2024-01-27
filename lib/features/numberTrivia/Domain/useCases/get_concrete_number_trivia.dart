import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entites/number_trivia.dart';
import '../repos/number_trivia_repos.dart';

class GetConcreteNumberTrivia {
  final NumberTriviaRepos repos;

  GetConcreteNumberTrivia(this.repos);

  Future<Either<Failure, NumberTrivia>> execute({required int number}) async {
    return await repos.getConcreteNumberTrivia(number);
  }
}
