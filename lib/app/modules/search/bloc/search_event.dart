abstract class SearchEvent {}

class SearchTextChanged extends SearchEvent {
  final String text;
  SearchTextChanged(this.text);
}

class StartSearch extends SearchEvent {
  final String query;

  StartSearch(this.query);
}
