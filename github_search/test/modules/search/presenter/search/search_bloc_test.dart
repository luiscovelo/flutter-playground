import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/modules/search/domain/entities/result_search.dart';
import 'package:github_search/modules/search/domain/usecases/search_by_text.dart';
import 'package:github_search/modules/search/presenter/search/search_bloc.dart';
import 'package:github_search/modules/search/presenter/search/states/state.dart';
import 'package:mocktail/mocktail.dart';

class SearchByTextMock extends Mock implements SearchByText {}

void main() {
  late SearchByText usecase;
  late SearchBloc bloc;

  setUp(() {
    usecase = SearchByTextMock();
    bloc = SearchBloc(usecase);
  });

  test('deve retornar os estados na ordem correta', () {
    when(() => usecase(any())).thenAnswer(
      (_) async => const Right(<ResultSearch>[]),
    );

    expectLater(
        bloc.stream,
        emitsInOrder([
          isA<SearchLoading>(),
          isA<SearchSuccess>(),
        ]));

    bloc.add("luiscovelo");
  });
}
