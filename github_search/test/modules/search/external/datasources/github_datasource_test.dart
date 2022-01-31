import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/modules/search/domain/errors/errors.dart';
import 'package:github_search/modules/search/external/datasources/github_datasource.dart';
import 'package:github_search/modules/search/infra/datasources/search_datasource.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/mocks/github_response.dart';

class MockDio extends Mock implements Dio {}

class RequestOptionsMock extends Mock implements RequestOptions {}

void main() {
  late Dio dio;
  late SearchDatasource datasource;

  setUp(() {
    dio = MockDio();
    datasource = GithubDatasource(dio);
  });

  const tSearchText = "luiscovelo";

  test('deve retornar uma lista de ResultSearchModel', () async {
    when(() => dio.get(any())).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptionsMock(),
        data: jsonDecode(githubResponse),
        statusCode: 200,
      ),
    );

    final result = datasource.getSearch(tSearchText);
    expect(result, completes);
  });

  test('deve retornar um DatasourceError caso statusCode for diferente de 200',
      () async {
    when(() => dio.get(any())).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptionsMock(),
        data: {},
        statusCode: 401,
      ),
    );

    final result = datasource.getSearch(tSearchText);
    expect(result, throwsA(isA<DatasourceError>()));
  });

  test('deve retornar um Exception se tiver erro no dio', () async {
    when(() => dio.get(any())).thenThrow(Exception());

    final result = datasource.getSearch(tSearchText);
    expect(result, throwsA(isA<Exception>()));
  });
}
