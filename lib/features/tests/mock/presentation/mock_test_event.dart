import 'package:dri_learn/features/tests/description/domain/model/answer_model.dart';
import 'package:equatable/equatable.dart';

abstract class MockTestEvent extends Equatable {
  const MockTestEvent();

  @override
  List<Object> get props => [];
}

class LoadTestEvent extends MockTestEvent {}

class SubmitAnswerEvent extends MockTestEvent {
  final AnswerModel answer;

  const SubmitAnswerEvent(this.answer);

  @override
  List<Object> get props => [answer];
}
