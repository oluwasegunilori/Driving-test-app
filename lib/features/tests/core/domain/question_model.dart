import 'package:dri_learn/features/tests/core/domain/question_type_model.dart';
import 'package:equatable/equatable.dart';

class QuestionModel extends Equatable {
  final String? id;
  final String question;
  final List<String> options;
  final String? image;
  final int answer;
  final QuestionType questionType;

  const QuestionModel(
      {this.id,
      required this.question,
      required this.options,
      this.image,
      required this.answer,
      required this.questionType});

  @override
  List<Object?> get props => [question, options, image, answer, questionType];
}

final List<QuestionModel> questionsStat = [
  const QuestionModel(
      question: "What is the capital of France?",
      options: ["Paris", "London", "Rome", "Berlin"],
      answer: 0,
      questionType: QuestionType.Knowledge,
      id: "00",
      image: "https://unsplash.com/photos/C7-PNQF5hww/download?force=true"),
  const QuestionModel(
      question: "Which of the following are fruits?",
      options: ["Apple", "Carrot", "Banana", "Potato"],
      answer: 0,
      questionType: QuestionType.Knowledge,
      id: "01"),
  const QuestionModel(
      question: "Is the Earth flat?",
      options: ["True", "False"],
      answer: 1,
      questionType: QuestionType.Knowledge,
      id: "AA"),
  const QuestionModel(
      question: "What is the sum of 2 and 3?",
      options: ["3", "4", "5", "6"],
      answer: 2,
      questionType: QuestionType.Knowledge,
      id: "AB"),
  const QuestionModel(
      question: "Select the prime numbers:",
      options: ["2", "4", "5", "8"],
      answer: 0,
      questionType: QuestionType.Knowledge,
      id: "AC"),
  const QuestionModel(
      question: "Is Python a programming language?",
      options: ["True", "False"],
      answer: 0,
      questionType: QuestionType.Knowledge,
      id: "AD"),
  const QuestionModel(
      question: "Which country is known as the Land of the Rising Sun?",
      options: ["China", "Japan", "Korea", "India"],
      answer: 1,
      questionType: QuestionType.Knowledge,
      id: "AE"),
  const QuestionModel(
      question: "Which of these are programming languages?",
      options: ["Python", "HTML", "C++", "Photoshop"],
      answer: 0,
      questionType: QuestionType.Knowledge,
      id: "AF"),
  const QuestionModel(
      question: "Is water composed of hydrogen and oxygen?",
      options: ["True", "False"],
      answer: 0,
      questionType: QuestionType.Knowledge,
      id: "AG"),
  const QuestionModel(
      question: "What is the largest planet in our solar system?",
      options: ["Earth", "Mars", "Jupiter", "Saturn"],
      answer: 2,
      questionType: QuestionType.Knowledge,
      id: "AH"),
];
