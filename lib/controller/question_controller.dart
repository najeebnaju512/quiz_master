import 'dart:convert';
import 'dart:math';

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
  int result = 0;

  var baseurl = 'https://nice-lime-hippo-wear.cyclic.app/api/v1/quiz';

  fetchData() async {
    isloading = true;
    notifyListeners();
    final url = Uri.parse(baseurl);
    try {
      final response = await http.get(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        quizlist = decodedData.map((e) => QuestionModel.fromJson(e)).toList();
        print("decodeData api Succeses");
      }
    } catch (e) {
      print(e);
    }
    isloading = false;
    notifyListeners();
  }

  checktapped(int index) {
    if (isTapped == false) {
      isCorrect = quizlist?[questionNo].options[index].isCorrect;
      tappedIndex = index;
      isTapped = true;
      notifyListeners();
    }
  }

  nextQueistion(BuildContext context) {
    if (quizlist?[questionNo].options[tappedIndex].isCorrect == true) {
      result++;
      print("result is $result");
      if (result == quizlist!.length-1) {
        result = 0;
      }
      notifyListeners();
    }

    if (questionNo != 4) {
      questionNo++;
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Resultpage(
                correctAns: result,
                totalQst: quizlist!.length,
              )));
      questionNo = 0;
    }
    // result = 0;
    // questionNo = 0;
    tappedIndex = null;
    isTapped = false;
    notifyListeners();
  }
}
