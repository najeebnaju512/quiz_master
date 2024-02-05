import 'package:flutter/material.dart';
import 'package:quiz_master/utils/color.dart';
import 'package:quiz_master/view/ques_page.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundClr,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>QuestionPage())),
              child: Image.asset("asset/images/Splash_image.png")
            ),
          ),
          
          
        ],
      ),
    );
  }
}
