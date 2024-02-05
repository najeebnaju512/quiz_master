import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:quiz_master/controller/question_controller.dart';
import 'package:quiz_master/utils/color.dart';
import 'package:provider/provider.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  var percent;
  @override
  void initState() {
    fetchQuestion();
    super.initState();
  }

  void fetchQuestion() async {
    await Provider.of<QuestionController>(context, listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    QuestionController provider = Provider.of<QuestionController>(context);
    var percent = ((provider.questionNo / provider.quizlist!.length) * 100);
    return Scaffold(
      backgroundColor: backgroundClr,
      body: provider.isloading
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.white54,
            ))
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //progress bar
                  Container(
                    padding: EdgeInsets.all(20),
                    child: RoundedProgressBar(
                        reverse: true,
                        height: 25,
                        percent: percent,
                        theme: RoundedProgressBarTheme.purple),
                  ),
                  // //questions shown
                  SizedBox(
                      child: Text(
                    "${provider.quizlist?[provider.questionNo].question ?? ''}",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  )),
                  // options shown
                  Container(
                    height: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: provider
                            .quizlist?[provider.questionNo].options.length,
                        itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: InkWell(
                                onTap: () {
                                  Provider.of<QuestionController>(context,
                                          listen: false)
                                      .checktapped(index);
                                },
                                child: Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: provider.tappedIndex == index
                                          ? provider.isCorrect
                                              ? Colors.green
                                              : Colors.red
                                          : Colors.transparent,
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Text(
                                      "${index + 1}. ${provider.quizlist?[provider.questionNo].options[index].text}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                  ),
                  //button at the end
                  InkWell(
                    onTap: () {
                      Provider.of<QuestionController>(context, listen: false)
                          .nextQueistion(context);
                    },
                    child: Center(
                      child: Visibility(
                          // visible: provider.questionNo == 4 ? false : true,
                          child: Container(
                        height: 50,
                        width: 180,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: Center(
                          child: Text(
                            "Next",
                            style: TextStyle(
                                color: backgroundClr,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
