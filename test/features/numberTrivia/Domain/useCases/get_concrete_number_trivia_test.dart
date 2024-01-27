/*import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/features/numberTrivia/Domain/entites/number_trivia.dart';
import 'package:number_trivia/features/numberTrivia/Domain/repos/number_trivia_repos.dart';
import 'package:number_trivia/features/numberTrivia/Domain/useCases/get_concrete_number_trivia.dart';*/

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/features/numberTrivia/Domain/entites/number_trivia.dart';
import 'package:number_trivia/features/numberTrivia/Domain/repos/number_trivia_repos.dart';
import 'package:number_trivia/features/numberTrivia/Domain/useCases/get_concrete_number_trivia.dart';

class MockNumberTriviaRepository extends Mock implements NumberTriviaRepos {}

void main() {
  late GetConcreteNumberTrivia usecase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });

  final tNumber = 1;
  final tNumberTrivia = NumberTrivia(number: 1, message: 'test');

  test(
    'should get trivia for the number from the repository',
    () async {
      // arrange
      when(mockNumberTriviaRepository.getConcreteNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));
      // act
      final result = await usecase.execute(number: tNumber);
      // assert
      expect(result, Right(tNumberTrivia));
      verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}
