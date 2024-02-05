part of 'number_trivia_bloc.dart';

sealed class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent {
  final String numString;

  const GetTriviaForConcreteNumber({required this.numString});
  @override
  List<Object> get props => [numString];
}

class GetTriviaForRandomNumber extends NumberTriviaEvent {}
