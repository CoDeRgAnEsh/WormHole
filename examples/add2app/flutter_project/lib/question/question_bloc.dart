import 'dart:async';

import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter_bridge/flutter_bridge.dart';
import 'package:flutter_project/question/model/answer.dart';
import 'package:flutter_project/question/question_controller.dart';
import 'package:rxdart/rxdart.dart';

import 'model/question.dart';

part 'question_bloc.g.dart';

@FlutterBridge()
class QuestionBloc implements Bloc {

  @InjectBinding()
  QuestionController questionBridge;

  final _questionToDisplay = BehaviorSubject<Question>();
  Observable<Question> get questionToDisplay => _questionToDisplay.stream;

  QuestionBloc() {
    Bridge$QuestionBloc("question").expose(this);
  }

  @Expose("question")
  void question(Question question) {
    _questionToDisplay.add(question);
  }

  void onAnswer(String answer) {
    questionBridge.answer(Answer(answer));
  }

  @override
  void dispose() {
    _questionToDisplay.close();
  }
}