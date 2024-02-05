import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entites/number_trivia.dart';
import '../repos/number_trivia_repos.dart';

class GetConcreteNumberTrivia implements Usecase<NumberTrivia, Params> {
  final NumberTriviaRepos repos;

  GetConcreteNumberTrivia(this.repos);
  @override
  Future<Either<Failures, NumberTrivia>> call(Params params) async {
    return await repos.getConcreteNumber(params.number);
  }
}

class Params extends Equatable {
  final int number;

  const Params({required this.number});
  @override
  List<Object> get props => [number];
}
