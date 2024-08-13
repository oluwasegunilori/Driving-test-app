// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:dri_learn/features/gemini/domain/repository/gemini_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

part 'gemini_event.dart';
part 'gemini_state.dart';

class GeminiBloc extends Bloc<GeminiEvent, GeminiState> {
  final GeminiRepo geminiRepo;

  GeminiBloc(this.geminiRepo) : super(GeminInitial());

  @override
  void onEvent(GeminiEvent event) {
    super.onEvent(event);
    if (event is FetchResultEvent) {
      var answer = "";
      geminiRepo.generateAnswer("Tell me about flutter in 5 lines").listen(
        (value) {
          answer = "$answer${value.output}";
        },
        onDone: () {
          emit(GeminiTextStreamer(text: answer));
        },
      ).onError((error) {});
    }
  }

  void doFetchResultEvent(FetchResultEvent event) {}
}
