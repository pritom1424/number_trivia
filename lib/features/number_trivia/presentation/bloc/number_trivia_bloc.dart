import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivia/core/errors/failures.dart';
import 'package:number_trivia/core/usecases/usecase.dart';
import 'package:number_trivia/core/utils/input_converter.dart';
import 'package:number_trivia/features/number_trivia/domain/entites/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/useCases/get_concrete_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/useCases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = "Server failed";
const String CACHE_FAILURE_MESSAGE = "Server failed";
const String INVALID_INPUT_FAILURE_MESSAGE =
    "Invalid Input - The number must be non negative";

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final InputConverter inputConverter;
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  NumberTriviaBloc(
      {required this.inputConverter,
      required this.getConcreteNumberTrivia,
      required this.getRandomNumberTrivia})
      : super(Empty()) {
    on<GetTriviaForConcreteNumber>((event, emit) async {
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.numString);
      await inputEither.fold((failures) {
        emit(const Error(message: INVALID_INPUT_FAILURE_MESSAGE));
      }, (integer) async {
        emit(Loading());
        final failurOrTrivia =
            await getConcreteNumberTrivia(Params(number: integer));
        emit(_eitherLoadedorErrorState(failurOrTrivia));
      });
    });

    /*  on<GetTriviaForConcreteNumber>((event, emit) async {
      emit(Loading());
      final failureOrtrivia = await getConcreteNumberTrivia(Params(number: 1));

      emit(_eitherLoadedorErrorState(failureOrtrivia));
    }); */

    on<GetTriviaForRandomNumber>((event, emit) async {
      emit(Loading());
      final failureOrtrivia = await getRandomNumberTrivia(NoParams());

      emit(_eitherLoadedorErrorState(failureOrtrivia));
    });
  }

  NumberTriviaState _eitherLoadedorErrorState(
      Either<Failures, NumberTrivia> failureOrTrivia) {
    return failureOrTrivia.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)), (trivia) {
      print(trivia);
      return Loaded(trivia: trivia);
    });
  }

  String _mapFailureToMessage(Failures failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure _:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
