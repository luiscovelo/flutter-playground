import 'package:bloc/bloc.dart';
import 'package:github_search/modules/search/domain/usecases/search_by_text.dart';
import 'package:github_search/modules/search/presenter/search/states/state.dart';

class SearchBloc extends Bloc<String, SearchState> {
  final SearchByText usecase;

  SearchBloc(this.usecase) : super(SearchStart()) {
    on<String>(_search);
  }

  void _search(String event, Emitter<SearchState> emit) async {
    emit(SearchLoading());
    final result = await usecase.call(event);
    result.fold(
      (error) => emit(SearchError()),
      (success) => emit(SearchSuccess(success)),
    );
  }
}
