abstract class SearchEvent {}

class SearchRequestEvent extends SearchEvent {
  String query;
  SearchRequestEvent({required this.query});
}

class ClearSearchEvent extends SearchEvent {}
