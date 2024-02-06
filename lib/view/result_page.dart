import 'package:flutter/material.dart';
import 'package:quiz_master/utils/color.dart';
import 'package:quiz_master/view/splash.dart';


class Resultpage extends StatefulWidget {
  final int correctAns;
  final int totalQst;
  const Resultpage(
      {super.key, required this.correctAns, required this.totalQst});

  @override
  State<Resultpage> createState() => _ResultpageState();
}

class _ResultpageState extends State<Resultpage> {
  var totalResult;
  var isPass;

  @override
  void initState() {
    totalResult = (((widget.correctAns / widget.totalQst) * 100));
    if (totalResult > 50) {
      isPass = true;
    } else {
      isPass = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundClr,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: Column(
                children: [
                  Image.asset(
                    "asset/images/congrats.png",
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${totalResult}% Score",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: isPass ? Colors.green : Colors.red,
                    ),
                  ),
                  Text("Quiz Completed Successfully..!"),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "You attempt ${widget.totalQst} Questions and \nfrom that ${widget.correctAns} answer is correct.",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Splash()));

              // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>isPass?Splash():QuestionPage()));
            },
            child: Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: isPass ? Colors.green : Colors.red),
                child: isPass
                    ? Center(
                        child: Text(
                          "Back.!",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    : Center(
                        child: Text(
                          "Try again",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      )),
          )
        ],
      ),
    );
  }
}
