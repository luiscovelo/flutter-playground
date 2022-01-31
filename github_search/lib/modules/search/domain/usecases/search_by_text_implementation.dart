import 'package:github_search/modules/search/domain/errors/errors.dart';
import 'package:github_search/modules/search/domain/entities/result_search.dart';
import 'package:dartz/dartz.dart';
import 'package:github_search/modules/search/domain/repositories/search_repository.dart';
import 'package:github_search/modules/search/domain/usecases/search_by_text.dart';

class SearchByTextImplementation implements SearchByText {
  final SearchRepository repository;

  SearchByTextImplementation(this.repository);
  @override
  Future<Either<FailureSearch, List<ResultSearch>>> call(
      String? searchText) async {
    if (searchText == null) {
      return Left(InvalidTextError());
    }

    if (searchText.isEmpty) {
      return Left(EmptyTextError());
    }

    return repository.search(searchText);
  }
}
