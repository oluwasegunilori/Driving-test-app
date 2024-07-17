part of 'test_history_bloc.dart';

sealed class TestHistoryState extends Equatable {
  const TestHistoryState();

  @override
  List<Object> get props => [];
}

final class TestHistoryInitial extends TestHistoryState {}

final class TestHistoryLoaded extends TestHistoryState {
  final Map<TestType, TestHistoryItem> data;

  const TestHistoryLoaded({required this.data});
}
