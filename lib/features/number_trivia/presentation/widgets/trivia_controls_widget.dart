import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

class TriviaControlsWidgets extends StatefulWidget {
  const TriviaControlsWidgets({super.key});

  @override
  State<TriviaControlsWidgets> createState() => _TriviaControlsWidgetsState();
}

class _TriviaControlsWidgetsState extends State<TriviaControlsWidgets> {
  final controller = TextEditingController();
  String inputStr = "";

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
              border: OutlineInputBorder(), hintText: "input a number"),
          onChanged: (value) {
            inputStr = value;
          },
          onSubmitted: (_) {
            dispatchConcrete();
          },
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
                    onPressed: dispatchConcrete,
                    child: const Text(
                      "Search",
                    ))),
            const SizedBox(width: 10),
            Expanded(
                child: ElevatedButton(
                    onPressed: dispatchRandom,
                    child: const Text(
                      "Get Random Trivia",
                    )))
          ],
        )
      ],
    );
  }

  void dispatchConcrete() {
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context)
        .add(GetTriviaForConcreteNumber(numString: inputStr));
  }

  void dispatchRandom() {
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context).add(GetTriviaForRandomNumber());
  }
}
