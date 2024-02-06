import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quiz_master/model/data_model.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_master/view/result_page.dart';

class QuestionController extends ChangeNotifier {
  late QuestionModel questionModel;
  bool isloading = false;
  List<dynamic>? quizlist;
  int questionNo = 0;
  bool isCorrect = false;
  int? tappedIndex;
  bool isTapped = false;
  late int result ;

  var baseurl = 'https://nice-lime-hippo-wear.cyclic.app/api/v1/quiz';

  fetchData() async {
    isloading = true;
    //resting score every time restart
    result = 0;
    notifyListeners();
    final url = Uri.parse(baseurl);
    try {
      final response = await http.get(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        // taking key value pair into a map
        final decodedData = jsonDecode(response.body);
        // changing map to list
        quizlist = decodedData.map((e) => QuestionModel.fromJson(e)).toList();
        print("decodeData api Succeses");
      }
    } catch (e) {
      print(e);
    }
    isloading = false;
    notifyListeners();
  }

  //assess the tapped answer is correct to used to change color to calculate score
  checktapped(int index) {
    if (isTapped == false) {
      //checks whether the tapped option is correct or not
      isCorrect = quizlist?[questionNo].options[index].isCorrect;
      //records the index of the option that the user tapped
      tappedIndex = index;
      isTapped = true;
      notifyListeners();
    }
  }

  nextQueistion(BuildContext context) {
    //to  assess the tapped answer is correct to set score
    if (quizlist?[questionNo].options[tappedIndex].isCorrect == true) {
      result++;
      print("result is $result");
      notifyListeners();
    }
    //to change the question no there by calling new question through refactoring till last question(4th)
    if (questionNo != 4) {
      questionNo++;
    } else {
      //after 4th question push to resul page
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Resultpage(
                correctAns: result, //transfering score data to result page
                totalQst: quizlist!
                    .length, //transfering total no of questions to result page
              )));
      //changed to 0 th index to restart from the start
      questionNo = 0;
    }
    //clearing to default
    tappedIndex = null;
    isTapped = false;
    notifyListeners();
  }
}
