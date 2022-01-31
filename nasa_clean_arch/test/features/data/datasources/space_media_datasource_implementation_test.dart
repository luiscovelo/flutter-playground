import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_arch/core/usecase/errors/exceptions.dart';
import 'package:nasa_clean_arch/core/utils/converters/date_to_string_converter.dart';
import 'package:nasa_clean_arch/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_clean_arch/features/data/datasources/nasa_datasource_implementation.dart';
import 'package:http/http.dart' as http;
import 'package:nasa_clean_arch/features/data/models/space_media_model.dart';

import '../../../mocks/space_media_mock.dart';

class MockDateToStringConverter extends Mock implements DateToStringConverter {}

class HttpClientMock extends Mock implements http.Client {}

void main() {
  late ISpaceMediaDatasource datasource;
  late http.Client client;
  late DateToStringConverter converter;

  setUp(() {
    converter = MockDateToStringConverter();
    client = HttpClientMock();
    datasource =
        NasaDatasourceImplementation(client: client, converter: converter);
    registerFallbackValue(DateTime(2000));
    registerFallbackValue(Uri());
  });

  final tDateTime = DateTime(2022, 1, 30);
  const tDateTimeString = '2021-02-02';

  const tSpaceMediaModel = SpaceMediaModel(
    description: 'example',
    mediaType: 'image',
    title: 'title example',
    mediaUrl: 'https://example.com/image.png',
  );

  void successMock() {
    when(() => converter.convert(any())).thenReturn(tDateTimeString);
    when(() => client.get(any())).thenAnswer(
      (_) async => http.Response(
        spaceMediaMock,
        200,
      ),
    );
  }

  test('should call DateInputConverter to convert the DateTime into a String',
      () async {
    // Arrange
    successMock();
    // Act
    await datasource.getSpaceMediaFromDate(tDateTime);
    // Assert
    verify(() => converter.convert(tDateTime)).called(1);
  });

  test('should call the get method with correct url', () async {
    // Arrange
    successMock();
    // Act
    await datasource.getSpaceMediaFromDate(tDateTime);
    // Assert
    verify(() => client.get(Uri.https('api.nasa.gov', '/planetary/apod', {
          'api_key': 'DEMO_KEY',
          'date': '2021-02-02',
        }))).called(1);
  });
  test('should return a SpaceMediaModel when the call is successful', () async {
    // Arrange
    successMock();
    // Act
    final result = await datasource.getSpaceMediaFromDate(tDateTime);
    // Assert
    expect(result, tSpaceMediaModel);
    verify(() => converter.convert(tDateTime)).called(1);
  });
  test('should throw a ServerException when the call is unccessful', () async {
    // Arrange
    when(() => converter.convert(any())).thenReturn(tDateTimeString);
    when(() => client.get(any()))
        .thenAnswer((_) async => http.Response('something went wrong', 400));
    // Act
    final result = datasource.getSpaceMediaFromDate(tDateTime);
    // Assert
    expect(() => result, throwsA(ServerException()));
    verify(() => converter.convert(tDateTime)).called(1);
  });
}
