import 'package:equatable/equatable.dart';

class NumberTrivia extends Equatable {
  final String message;
  final int number;

  const NumberTrivia({required this.message, required this.number});

  @override
  List<Object?> get props => [message, number];
}
