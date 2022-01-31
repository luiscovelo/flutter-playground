import 'package:dartz/dartz.dart';
import 'package:github_search/modules/search/domain/entities/result_search.dart';
import 'package:github_search/modules/search/domain/errors/errors.dart';

abstract class SearchByText {
  Future<Either<FailureSearch, List<ResultSearch>>> call(String? searchText);
}
