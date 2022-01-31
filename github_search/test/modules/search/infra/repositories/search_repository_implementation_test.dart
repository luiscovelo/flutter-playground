import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/modules/search/domain/entities/result_search.dart';
import 'package:github_search/modules/search/domain/errors/errors.dart';
import 'package:github_search/modules/search/domain/errors/exceptions.dart';
import 'package:github_search/modules/search/domain/repositories/search_repository.dart';
import 'package:github_search/modules/search/infra/datasources/search_datasource.dart';
import 'package:github_search/modules/search/infra/models/result_search_model.dart';
import 'package:github_search/modules/search/infra/repositories/search_repository_implementation.dart';
import 'package:mocktail/mocktail.dart';

class SearchDatasourceMock extends Mock implements SearchDatasource {}

void main() {
  late SearchRepository repository;
  late SearchDatasource datasource;

  setUp(() {
    datasource = SearchDatasourceMock();
    repository = SearchRepositoryImplementation(datasource);
  });

  const tSearchText = "luiscovelo";

  test('deve retornar uma lista de ResultSearch', () async {
    when(() => datasource.getSearch(any())).thenAnswer(
      (_) async => <ResultSearchModel>[],
    );
    final result = await repository.search(tSearchText);
    expect(result, isA<Right>());
    expect(result.getOrElse(() => []), isA<List<ResultSearch>>());
  });

  test('deve retornar um DatasourceError se o datasource falhar', () async {
    when(() => datasource.getSearch(any())).thenThrow(ServerException());
    final result = await repository.search(tSearchText);
    expect(result.fold(id, id), isA<DatasourceError>());
  });
}
