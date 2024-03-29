import 'package:equatable/equatable.dart';

abstract class Failures extends Equatable {
  const Failures();
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failures {}

class CacheFailure extends Failures {}
