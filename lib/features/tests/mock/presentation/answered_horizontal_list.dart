import 'package:dri_learn/core/text_style.dart';
import 'package:dri_learn/features/tests/core/domain/model/answer_model.dart';
import 'package:dri_learn/features/tests/mock/presentation/mock_test_bloc.dart';
import 'package:dri_learn/features/tests/mock/presentation/mock_test_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnsweredHorizontalList extends StatelessWidget {
  final List<AnswerModel> answers;
  final int currentPosition;
  const AnsweredHorizontalList(
      {super.key, required this.answers, required this.currentPosition});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Spacer(),
          ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: answers.length,
            itemBuilder: (context, index) {
              return InkWell(
                child: Container(
                  width: index == currentPosition
                      ? 40
                      : 28, // Set the width of each item
                  margin: const EdgeInsets.symmetric(
                      horizontal: 4.0), // Add spacing between items
                  decoration: BoxDecoration(
                    color: answers[index].question.answer ==
                            answers[index].userAnswer
                        ? Colors.green
                        : Theme.of(context).colorScheme.error,
                    shape: BoxShape.circle, // Make the corners rounded
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: titleSmall(context).copyWith(
                          color: Theme.of(context).colorScheme.surface),
                    ),
                  ),
                ),
                onTap: () {
                  BlocProvider.of<MockTestBloc>(context)
                      .add(NavigateToQuestionEvent(questionNo: index));
                },
              );
            },
          ),
          Spacer(),
        ],
      ),
    );
  }
}
