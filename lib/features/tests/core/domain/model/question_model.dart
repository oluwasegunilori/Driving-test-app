import 'package:dri_learn/features/tests/core/domain/model/test_type.dart';
import 'package:equatable/equatable.dart';

class QuestionModel extends Equatable {
  final String id;
  final String question;
  final List<String> options;
  final String? image;
  final String? imageLink;
  final String? geminiQuestion;
  final String? geminiAnswer;
  final int answer;
  final TestType testType;

  const QuestionModel(
      {required this.id,
      required this.question,
      required this.options,
      this.image,
      this.imageLink,
      this.geminiQuestion,
      this.geminiAnswer,
      required this.answer,
      required this.testType});

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
        id: json['id'],
        question: json['question'],
        options: List<String>.from(json['options']),
        image: json['image'],
        imageLink: json['imageLink'],
        geminiQuestion: json['geminiQuestion'],
        geminiAnswer: json['geminiAnswer'],
        answer: int.parse(json['answer']),
        testType: TestType.fromString(json['type']));
  }

  @override
  List<Object?> get props =>
      [question, options, image, answer, testType, imageLink, geminiQuestion];
}

// final List<QuestionModel> questionsStat = [
//   const QuestionModel(
//       question: "What is the capital of France?",
//       options: ["Paris", "London", "Rome", "Berlin"],
//       answer: 0,
//       testType: QuestionType.Knowledge,
//       id: "00",
//       image: "https://unsplash.com/photos/C7-PNQF5hww/download?force=true"),
//   const QuestionModel(
//       question: "Which of the following are fruits?",
//       options: ["Apple", "Carrot", "Banana", "Potato"],
//       answer: 0,
//       testType: QuestionType.Knowledge,
//       id: "01"),
//   const QuestionModel(
//       question: "Is the Earth flat?",
//       options: ["True", "False"],
//       answer: 1,
//       testType: QuestionType.Knowledge,
//       id: "AA"),
//   const QuestionModel(
//       question: "What is the sum of 2 and 3?",
//       options: ["3", "4", "5", "6"],
//       answer: 2,
//       testType: QuestionType.Knowledge,
//       id: "AB"),
//   const QuestionModel(
//       question: "Select the prime numbers:",
//       options: ["2", "4", "5", "8"],
//       answer: 0,
//       testType: QuestionType.Knowledge,
//       id: "AC"),
//   const QuestionModel(
//       question: "Is Python a programming language?",
//       options: ["True", "False"],
//       answer: 0,
//       testType: QuestionType.Knowledge,
//       id: "AD"),
//   const QuestionModel(
//       question: "Which country is known as the Land of the Rising Sun?",
//       options: ["China", "Japan", "Korea", "India"],
//       answer: 1,
//       testType: QuestionType.Knowledge,
//       id: "AE"),
//   const QuestionModel(
//       question: "Which of these are programming languages?",
//       options: ["Python", "HTML", "C++", "Photoshop"],
//       answer: 0,
//       testType: QuestionType.Knowledge,
//       id: "AF"),
//   const QuestionModel(
//       question: "Is water composed of hydrogen and oxygen?",
//       options: ["True", "False"],
//       answer: 0,
//       testType: QuestionType.Knowledge,
//       id: "AG"),
//   const QuestionModel(
//       question: "What is the largest planet in our solar system?",
//       options: ["Earth", "Mars", "Jupiter", "Saturn"],
//       answer: 2,
//       testType: QuestionType.Knowledge,
//       id: "AH"),
// ];
