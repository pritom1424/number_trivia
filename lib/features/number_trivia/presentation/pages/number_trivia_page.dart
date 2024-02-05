import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:number_trivia/features/number_trivia/presentation/widgets/loaded_display_trivia_widget.dart';
import 'package:number_trivia/features/number_trivia/presentation/widgets/loading_display_widget.dart';
import 'package:number_trivia/features/number_trivia/presentation/widgets/message_display_widget.dart';
import 'package:number_trivia/features/number_trivia/presentation/widgets/trivia_controls_widget.dart';
import 'package:number_trivia/injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Number Trivia"),
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext ctx) {
    return BlocProvider(
      create: (_) => sl<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                  builder: (ctx, state) {
                if (state is Loading) {
                  return const LoadingDisplayWidget();
                } else if (state is Loaded) {
                  return LoadedDisplayTriviaWidget(numberTrivia: state.trivia);
                } else if (state is Error) {
                  return MessageDisplayWidget(message: state.message);
                }
                return const MessageDisplayWidget(
                  message: 'Start searching!',
                );
              }),
              const SizedBox(
                height: 20,
              ),
              const TriviaControlsWidgets(),
            ],
          ),
        ),
      ),
    );
  }
}
