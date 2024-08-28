import 'package:ontario_g1_test_2024/features/tests/mock/presentation/mock_test_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

enum Grade {
  Poor(img: "poor_score.png"),
  Medium(img: "medium_score.png"),
  Excellent(img: "excellent_score.png");

  final String img;

  const Grade({required this.img});
}

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
            description:
                "Don't be discouraged! You didn't pass this time, but with more practice, you'll get there.",
            score: "${state.info.score}/${state.questions.length}",
            title: "Poor");
      }
    case Grade.Medium:
      {
        return ScoreInfo(
            rating: state.info.grade,
            description: "God job but not enough! You need at let 80%.",
            score: "${state.info.score}/${state.questions.length}",
            title: "Medium");
      }
    case Grade.Excellent:
      {
        return ScoreInfo(
            rating: state.info.grade,
            description:
                "Congratulations! You passed the test! Keep up the great work you're one step closer to acing your driving test!",
            score: "${state.info.score}/${state.questions.length}",
            title: "Excellent");
      }
  }
}
