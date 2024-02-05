import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:number_trivia/core/errors/exceptions.dart';

import '../models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSources {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int numb);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourcesImpl
    implements NumberTriviaRemoteDataSources {
  NumberTriviaRemoteDataSourcesImpl();

  String mainUrl = "numbersapi.com";
  final header = {'Content-Type': 'application/json'};

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int numb) =>
      _getTriviaFromUrl("$numb");

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() =>
      _getTriviaFromUrl("random");

  Future<NumberTriviaModel> _getTriviaFromUrl(String urlPath) async {
    final uri = Uri.http(mainUrl, "/$urlPath");
    final response = await http.get(uri, headers: header);
    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
