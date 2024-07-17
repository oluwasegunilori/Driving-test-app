import 'package:bloc/bloc.dart';
import 'package:dri_learn/features/history/domain/model/test_history_item.dart';
import 'package:dri_learn/features/history/domain/model/test_history_model.dart';
import 'package:dri_learn/features/history/domain/usecase/get_test_history_usecase.dart';
import 'package:dri_learn/features/tests/core/domain/model/test_type.dart';
import 'package:equatable/equatable.dart';

part 'test_history_event.dart';
part 'test_history_state.dart';

class TestHistoryBloc extends Bloc<TestHistoryEvent, TestHistoryState> {
  final GetTestHistoryUsecase getTestHistoryUsecase;

  TestHistoryBloc(this.getTestHistoryUsecase) : super(TestHistoryInitial()) {
    loadTest();
  }

  void loadTest() async {
    Map<TestType, TestHistoryItem> result = await getTestHistoryUsecase.call();
    emit(TestHistoryLoaded(data: result));
  }
}
