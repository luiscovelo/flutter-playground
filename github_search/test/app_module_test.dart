import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/app_module.dart';
import 'package:github_search/modules/search/domain/entities/result_search.dart';
import 'package:github_search/modules/search/domain/usecases/search_by_text.dart';
import 'package:github_search/modules/search/domain/usecases/search_by_text_implementation.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';

import 'modules/utils/mocks/github_response.dart';

class MockDio extends Mock implements Dio {}

class RequestOptionsMock extends Mock implements RequestOptions {}

void main() {
  late Dio dio;

  setUp(() {
    dio = MockDio();
    initModule(AppModule(), replaceBinds: [
      Bind<Dio>((i) => dio),
    ]);
  });

  test('deve recuperar o usecase sem erro', () {
    final usecase = Modular.get<SearchByText>();
    expect(usecase, isA<SearchByTextImplementation>());
  });

  test('deve trazer uma lista de ResultSearch', () async {
    when(() => dio.get(any())).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptionsMock(),
        data: jsonDecode(githubResponse),
        statusCode: 200,
      ),
    );

    final usecase = Modular.get<SearchByText>();
    final result = await usecase("luiscovelo");
    expect(result.getOrElse(() => []), isA<List<ResultSearch>>());
  });
}
