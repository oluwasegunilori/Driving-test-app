part of 'test_history_bloc.dart';

sealed class TestHistoryEvent extends Equatable {
  const TestHistoryEvent();

  @override
  List<Object> get props => [];
}

class LoadTestEvent extends TestHistoryEvent {}
