import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_arch/core/http_client/http_client.dart';
import 'package:nasa_clean_arch/core/usecase/errors/exceptions.dart';
import 'package:nasa_clean_arch/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_clean_arch/features/data/datasources/nasa_datasource_implementation.dart';
import 'package:nasa_clean_arch/features/data/models/space_media_model.dart';

import '../../../mocks/space_media_mock.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  late ISpaceMediaDatasource datasource;
  late HttpClient client;

  setUp(() {
    client = HttpClientMock();
    datasource = NasaDatasourceImplementation(client);
  });

  final tDateTime = DateTime(2022, 1, 30);
  const urlExpected =
      'https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&date=2022-01-30';

  void successMock() {
    when(() => client.get(any())).thenAnswer(
      (_) async => HttpResponse(
        data: spaceMediaMock,
        statusCode: 200,
      ),
    );
  }

  void uncessfulMock() {
    when(() => client.get(any())).thenAnswer(
      (_) async => HttpResponse(
        data: 'something went wrong',
        statusCode: 400,
      ),
    );
  }

  test('should call the get method with correct url', () async {
    successMock();
    await datasource.getSpaceMediaFromDate(tDateTime);
    verify(() => client.get(urlExpected)).called(1);
  });

  test('should return a SpaceMediaModel when is successful', () async {
    successMock();
    const tSpaceMediaModelExpected = SpaceMediaModel(
      description: 'example',
      mediaType: 'image',
      title: 'title example',
      mediaUrl: 'https://example.com/image.png',
    );
    final result = await datasource.getSpaceMediaFromDate(tDateTime);
    expect(result, tSpaceMediaModelExpected);
  });

  test('should throw a ServerException when the call is uncessful', () {
    uncessfulMock();
    final result = datasource.getSpaceMediaFromDate(tDateTime);
    expect(() => result, throwsA(ServerException()));
  });
}
