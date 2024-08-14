import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dri_learn/core/router_config.dart';
import 'package:dri_learn/core/spaces.dart';
import 'package:dri_learn/core/text_style.dart';
import 'package:dri_learn/features/gemini/presentation/bloc/gemini_bloc.dart';
import 'package:dri_learn/features/tests/core/domain/model/answer_model.dart';
import 'package:dri_learn/features/tests/mock/presentation/answered_horizontal_list.dart';
import 'package:dri_learn/features/tests/mock/presentation/mock_test_bloc.dart';
import 'package:dri_learn/features/tests/mock/presentation/mock_test_event.dart';
import 'package:dri_learn/features/tests/mock/presentation/mock_test_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '/core/di/injection_container.dart' as di;

class MockTestScreen extends StatelessWidget {
  const MockTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var animatedQuestionIds = [];
    double imageHeight = MediaQuery.of(context).size.height * 0.27;
    GeminiBloc geminiBloc = di.sl<GeminiBloc>();
    String currentTestType =
        BlocProvider.of<MockTestBloc>(context).getCurrentTestType();
    return BlocProvider(
      create: (context) => geminiBloc,
      child: BlocBuilder<MockTestBloc, MockTestState>(
        builder: (context, state) {
          return Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: imageHeight,
                      child: Stack(
                        children: [
                          Card(
                            margin: const EdgeInsets.all(0),
                            shadowColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  15.0), // Adjust the border radius as needed
                              child: (state is TestLoaded &&
                                      state.getCurrentQuestion().image !=
                                          null &&
                                      state
                                              .getCurrentQuestion()
                                              .image!
                                              .toLowerCase() !=
                                          "link")
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 50),
                                      child: Image.asset(
                                        "assets/images/${state.getCurrentQuestion().image!}.jpg",
                                        fit: BoxFit
                                            .fitHeight, // This makes the image cover the entire area
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                    )
                                  : Image.asset(
                                      "assets/images/onboard_img.jpeg",
                                      fit: BoxFit
                                          .cover, // This makes the image cover the entire area
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                            ),
                          ),
                          Container(
                            color: Colors.black.withOpacity(0.2),
                          ),
                          Positioned(
                              bottom: 15,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    Icon(
                                      MdiIcons.car,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      size: 36,
                                    ),
                                    horizontalSpace(10),
                                    Text(
                                      currentTestType ?? "Mock Test",
                                      style: titleMedium(context)
                                          .copyWith(color: Colors.white),
                                    )
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 50,
                      child: IconButton(
                        onPressed: () {
                          if (context.canPop()) {
                            context.pop();
                          }
                        },
                        icon: Icon(
                          MdiIcons.chevronLeft,
                          size: 26,
                        ),
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  ],
                ),
                if (state is TestLoaded) ...[
                  verticalSpace(15),
                  if (state.viewMode) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: AnsweredHorizontalList(
                          answers: state.answers.values.toList(),
                          currentPosition: state.currentPosition,),
                    ),
                    verticalSpace(5),
                  ] else ...[
                    questionHeader(context, state),
                    verticalSpace(8),
                  ],
                ],
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ListView(
                        children: [
                          if (state is TestLoaded) ...[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.01),
                              child: Center(
                                child: Text(
                                  state.getCurrentQuestion().question,
                                  style: titleMedium(
                                    context,
                                    fontWeight: FontWeight.w500,
                                    size: 15,
                                  ).copyWith(height: 1.2),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            verticalSpace(15),
                            questionOptionWidget(context, state),
                            verticalSpace(20),
                            if (state.viewMode) ...[
                              BlocBuilder<GeminiBloc, GeminiState>(
                                builder: (context, gemState) {
                                  return Column(
                                    children: [
                                      Card(
                                        child: ListTile(
                                          title: InkWell(
                                            onTap: !isGeminiAnswerThere(
                                                    gemState, state)
                                                ? () {
                                                    geminiBloc.onEvent(
                                                        FetchResultEvent(
                                                            answerModel: state
                                                                .getCurrentAnswerModel()!));
                                                  }
                                                : null,
                                            child: Text(
                                              (gemState is GeminiTextStreamer) &&
                                                      isGeminiAnswerThere(
                                                          gemState, state)
                                                  ? "Answer"
                                                  : "Explain Answer",
                                            ),
                                          ),
                                          subtitle: isGeminiAnswerThere(
                                                      gemState, state) ||
                                                  animatedQuestionIds.contains(
                                                      state
                                                          .getCurrentQuestion()
                                                          .id)
                                              ? Text(getGeminiAnswer(
                                                  gemState, state))
                                              :
                                              //Animated Gemini text
                                              AnimatedTextKit(
                                                  key: Key(state.currentPosition
                                                      .toString()),
                                                  animatedTexts: [
                                                    TypewriterAnimatedText(
                                                      getGeminiAnswer(
                                                          gemState, state),
                                                      speed: const Duration(
                                                          milliseconds: 30),
                                                    ),
                                                  ],
                                                  totalRepeatCount: 1,
                                                  pause: const Duration(
                                                      milliseconds: 200),
                                                  displayFullTextOnTap: true,
                                                  stopPauseOnTap: true,
                                                  onFinished: () => {
                                                    animatedQuestionIds.add(state
                                                        .getCurrentQuestion()
                                                        .id)
                                                  },
                                                ),
                                          trailing: const Icon(Icons.light),
                                        ),
                                      ),
                                      verticalSpace(15)
                                    ],
                                  );
                                },
                              )
                            ],
                          ],
                          verticalSpace(100),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: (state is TestLoaded)
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: state.currentPosition == 0
                              ? const Text('')
                              : TextButton(
                                  onPressed: () {
                                    BlocProvider.of<MockTestBloc>(context)
                                        .add(PreviousQuestEvent());
                                  },
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Theme.of(context)
                                              .colorScheme
                                              .primary),
                                      overlayColor:
                                          const MaterialStatePropertyAll(
                                              Colors.black12),
                                      padding: const MaterialStatePropertyAll(
                                          EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 12))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        MdiIcons.undo,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                      ),
                                      horizontalSpace(10),
                                      Text(
                                        "Back",
                                        style: titleSmall(context)
                                            .copyWith(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                        horizontalSpace(10),
                        Expanded(
                          child: TextButton(
                            onPressed:
                                state.answers[state.getCurrentQuestion().id] !=
                                        null
                                    ? () {
                                        BlocProvider.of<MockTestBloc>(context)
                                            .add(SubmitAnswerEvent(AnswerModel(
                                                question: state.questions[
                                                    state.currentPosition],
                                                userAnswer: state
                                                    .answers[state
                                                        .getCurrentQuestion()
                                                        .id]!
                                                    .userAnswer)));
                                        if (state.isOnLastQuestion()) {
                                          context
                                              .push(TestCompleteRoute().route);
                                        }
                                      }
                                    : null,
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(state.answers[state
                                                    .getCurrentQuestion()
                                                    .id] ==
                                                null
                                            ? 0.4
                                            : 1)),
                                overlayColor: const MaterialStatePropertyAll(
                                    Colors.black12),
                                padding: const MaterialStatePropertyAll(
                                    EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 12))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  state.isOnLastQuestion()
                                      ? state.viewMode
                                          ? "Next"
                                          : "Submit"
                                      : "Next",
                                  style: titleSmall(context)
                                      .copyWith(color: Colors.white),
                                ),
                                horizontalSpace(10),
                                Icon(
                                  MdiIcons.redo,
                                  color: Theme.of(context).colorScheme.surface,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Center(),
          );
        },
      ),
    );
  }

  Padding questionHeader(BuildContext context, TestLoaded state) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.02),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withAlpha(50),
                shape: BoxShape.rectangle,
                borderRadius:
                    const BorderRadius.all(Radius.elliptical(30, 30))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: Text(
                "Questions ${(state).currentPosition + 1}/${(state).questions.length}",
                style: titleSmall(context).copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const Spacer(),
          InkWell(
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius:
                      const BorderRadius.all(Radius.elliptical(30, 30)),
                  border:
                      Border.all(color: Theme.of(context).colorScheme.primary)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                // child: Row(
                //   children: [
                //     Icon(MdiIcons.television),
                //     horizontalSpace(5),
                //     Text(
                //       "Visual Learning",
                //       style: titleSmall(context).copyWith(
                //           fontWeight: FontWeight.w600),
                //     ),
                //   ],
                // ),
              ),
            ),
            onTap: () {
              // showModalBottomSheet(
              //     context: context,
              //     builder: (context) {
              //       return Container(
              //           height: MediaQuery.of(context)
              //                   .size
              //                   .height *
              //               0.8,
              //           child:
              //               const RoadIntersectionWidget());
              //     },
              //     isScrollControlled: true);
            },
          ),
        ],
      ),
    );
  }

  String getGeminiAnswer(GeminiState gemState, TestLoaded state) {
    if (gemState is! GeminiTextStreamer) {
      return "";
    }
    return gemState.getByQuestionId(state.getCurrentQuestion().id)?.gemAnswer ??
        "";
  }

  bool isGeminiAnswerThere(GeminiState gemState, TestLoaded state) {
    if (gemState is GeminiTextStreamer) {
      return gemState
              .getByQuestionId(state.getCurrentQuestion().id)
              ?.gemAnswer
              ?.isNotEmpty ==
          true;
    } else {
      return false;
    }
  }

  Column questionOptionWidget(BuildContext context, TestLoaded state) {
    var userAnswer = state.answers[state.getCurrentQuestion().id]?.userAnswer;
    return Column(
      children: state.getCurrentQuestion().options.asMap().entries.map((entry) {
        return Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          color: userAnswer == entry.key
              ? isViewModeAndNotCorrectOption(state, entry.key)
                  ? Theme.of(context).colorScheme.error
                  : isViewModeAndCorrectOption(state, entry.key)
                      ? Colors.green
                      : Theme.of(context).colorScheme.tertiary
              : isViewModeAndCorrectOption(state, entry.key)
                  ? Colors.green
                  : Theme.of(context).colorScheme.surface,
          surfaceTintColor: Colors.white,
          elevation: 1,
          child: ListTile(
            title: Text(
              entry.value,
              style: titleSmall(context).copyWith(
                  color: userAnswer == entry.key
                      ? Colors.white
                      : Theme.of(context).colorScheme.onSurface,
                  fontSize: 13),
            ),
            trailing: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                  color: userAnswer == entry.key
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.surface,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: isViewModeAndCorrectOption(state, entry.key) &&
                              userAnswer != entry.key
                          ? Colors.green
                          : Theme.of(context).colorScheme.primary)),
              child: Center(
                child: Icon(
                    userAnswer == entry.key
                        ? isViewModeAndCorrectOption(state, entry.key)
                            ? MdiIcons.check
                            : !state.viewMode
                                ? MdiIcons.check
                                : MdiIcons.close
                        : isViewModeAndCorrectOption(state, entry.key)
                            ? MdiIcons.check
                            : null,
                    color: isViewModeAndCorrectOption(state, entry.key) &&
                            userAnswer != entry.key
                        ? Colors.green
                        : Theme.of(context).colorScheme.surface),
              ),
            ),
            onTap: () {
              BlocProvider.of<MockTestBloc>(context).add(SubmitAnswerEvent(
                  AnswerModel(
                    question: state.getCurrentQuestion(),
                    userAnswer: entry.key,
                  ),
                  goToNextQuestion: false));
            },
          ),
        );
      }).toList(),
    );
  }

  bool isViewModeAndCorrectOption(TestLoaded state, int key) {
    return state.viewMode && key == state.getCurrentQuestion().answer;
  }

  bool isViewModeAndNotCorrectOption(TestLoaded state, int key) {
    return state.viewMode &&
        key != state.getCurrentQuestion().answer &&
        key == state.getCurrentAnswerModel()!.userAnswer;
  }
}
