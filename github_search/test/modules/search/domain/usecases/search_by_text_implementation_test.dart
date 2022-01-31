import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/modules/search/domain/entities/result_search.dart';
import 'package:github_search/modules/search/domain/errors/errors.dart';
import 'package:github_search/modules/search/domain/repositories/search_repository.dart';
import 'package:github_search/modules/search/domain/usecases/search_by_text.dart';
import 'package:github_search/modules/search/domain/usecases/search_by_text_implementation.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchRepository extends Mock implements SearchRepository {}

void main() {
  late SearchRepository repository;
  late SearchByText usecase;
  const tSearchText = "luiscovelo";

  setUp(() {
    repository = MockSearchRepository();
    usecase = SearchByTextImplementation(repository);
  });

  test('deve retornar uma lista de ResultSearch', () async {
    when(() => repository.search(tSearchText)).thenAnswer(
      (_) async => const Right(<ResultSearch>[]),
    );

    final result = await usecase(tSearchText);
    expect(result, isA<Right>());
    expect(result.getOrElse(() => []), isA<List<ResultSearch>>());
  });

  test('deve retornar InvalidTextError caso o texto seja invalido', () async {
    when(() => repository.search(tSearchText)).thenAnswer(
      (_) async => const Right(<ResultSearch>[]),
    );

    final result = await usecase(null);
    expect(
      result.fold((error) => error, (success) => success),
      isA<InvalidTextError>(),
    );
  });

  test('deve retornar EmptyTextError caso o texto seja vazio', () async {
    when(() => repository.search(tSearchText)).thenAnswer(
      (_) async => const Right(<ResultSearch>[]),
    );

    final result = await usecase('');
    expect(
      result.fold((error) => error, (success) => success),
      isA<EmptyTextError>(),
    );
  });
}
