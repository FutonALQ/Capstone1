abstract class SearchState {}

final class SearchInitial extends SearchState {}

class LoadingState extends SearchState {}

class EmptyResponseState extends SearchState {
  String message;
  EmptyResponseState({required this.message});
}

class ResultResponseState extends SearchState {
  List response;
  ResultResponseState({required this.response});
}

class ClearSearchState extends SearchState {}
