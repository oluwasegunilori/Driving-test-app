// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:dri_learn/features/gemini/domain/model/gem_question_answer_model.dart';
import 'package:dri_learn/features/gemini/domain/repository/gemini_repo.dart';
import 'package:dri_learn/features/gemini/domain/usecase/generate_gemini_question.dart';
import 'package:dri_learn/features/tests/core/domain/model/answer_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

part 'gemini_event.dart';
part 'gemini_state.dart';

class GeminiBloc extends Bloc<GeminiEvent, GeminiState> {
  final GeminiRepo geminiRepo;
  final GenerateGeminiQuestionUsecase generateGeminiQuestionUsecase;

  GeminiBloc(this.geminiRepo, this.generateGeminiQuestionUsecase)
      : super(GeminInitial());

  @override
  void onEvent(GeminiEvent event) {
    super.onEvent(event);
    if (event is FetchResultEvent) {
      var answer = "";
      String question = generateGeminiQuestionUsecase(event.answerModel);
      geminiRepo.generateAnswer(question).then((value) {
        if (value?.output == null) {
          answer = "No anwser";
        } else {
          answer = "$answer${value?.output}";
        }
        if (state is GeminInitial) {
          emit(GeminiTextStreamer(answerModel: [
            GemQuestionAnswerModel(
                answerModel: event.answerModel, gemAnswer: answer)
          ]));
        } else if (state is GeminiTextStreamer) {
          List<GemQuestionAnswerModel> currentAnswerModel =
              List.from((state as GeminiTextStreamer).answerModel);
          currentAnswerModel.add(GemQuestionAnswerModel(
              answerModel: event.answerModel, gemAnswer: answer));
          emit(GeminiTextStreamer(answerModel: currentAnswerModel));
        }
      }).catchError((onError) {});
    }
  }

  void doFetchResultEvent(FetchResultEvent event) {}
}
