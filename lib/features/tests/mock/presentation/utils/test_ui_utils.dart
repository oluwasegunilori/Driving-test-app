import 'package:dri_learn/features/tests/mock/presentation/mock_test_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

enum Grade { Poor, Medium, Excellent }

class ScoreInfo extends Equatable {
  final Grade rating;
  final String description;
  final String score;
  final String title;

  const ScoreInfo(
      {required this.rating,
      required this.description,
      required this.score,
      required this.title});

  @override
  List<Object?> get props => [rating, description, score];
}

ScoreInfo getScoreInfo(BuildContext context, TestLoaded state) {
  switch (state.info.grade) {
    case Grade.Poor:
      {
        return ScoreInfo(
            rating: state.info.grade,
            description: "Poor result",
            score: "${state.info.score}/${state.questions.length}",
            title: "Poor");
      }
    case Grade.Medium:
      {
        return ScoreInfo(
            rating: state.info.grade,
            description: "Medium result",
            score: "${state.info.score}/${state.questions.length}",
            title: "Medium");
      }
    case Grade.Excellent:
      {
        return ScoreInfo(
            rating: state.info.grade,
            description: "Excellent result",
            score: "${state.info.score}/${state.questions.length}",
            title: "Excellent");
      }
  }
}
