import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_master/controller/question_controller.dart';
import 'package:quiz_master/view/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => QuestionController()),
      ],
      child: MaterialApp(
        home: Splash(),
      ),
    );
  }
}
