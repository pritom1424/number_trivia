import 'package:flutter/material.dart';

import 'circleProgress.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _anim;
  final maxProgress = 90.0;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 3000));
    _anim = Tween<double>(begin: 0, end: maxProgress).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Circle Progress Bar"),
        ),
        body: GestureDetector(
          onTap: () {
            (_anim.value >= maxProgress)
                ? _controller.reverse()
                : _controller.forward();
          },
          child: Center(
            child: CustomPaint(
              foregroundPainter:
                  CircleProgressBar(50, _anim.value, Colors.blue),
              child: Container(
                width: 300,
                height: 300,
                child: Center(
                    child: Text(
                  _anim.value.toInt().toString(),
                  style: TextStyle(fontSize: 50),
                )),
              ),
            ),
          ),
        ));
  }
}
