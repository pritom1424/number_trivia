import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/errors/failures.dart';

class InputConverter {
  Either<Failures, int> stringToUnsignedInteger(String str) {
    try {
      final integer = int.parse(str);
      if (integer < 0) throw const FormatException();
      return right(integer);
    } on FormatException {
      return Left(InvalidInputFailuer());
    }
  }
}

class InvalidInputFailuer extends Failures {}
