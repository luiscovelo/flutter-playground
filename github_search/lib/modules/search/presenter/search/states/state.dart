import 'package:github_search/modules/search/domain/entities/result_search.dart';

abstract class SearchState {}

class SearchSuccess implements SearchState {
  final List<ResultSearch> list;

  SearchSuccess(this.list);
}

class SearchError implements SearchState {}

class SearchLoading implements SearchState {}

class SearchStart implements SearchState {}

class SearchEmptyTerm implements SearchState {}
