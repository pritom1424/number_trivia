import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entites/number_trivia.dart';
import '../repos/number_trivia_repos.dart';

class GetRandomNumberTrivia implements Usecase<NumberTrivia, NoParams> {
  final NumberTriviaRepos repos;

  GetRandomNumberTrivia(this.repos);
  @override
  Future<Either<Failures, NumberTrivia>> call(NoParams params) async {
    return await repos.getRandomNumber();
  }
}
