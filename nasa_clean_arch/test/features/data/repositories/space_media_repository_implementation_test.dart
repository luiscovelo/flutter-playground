import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_arch/core/usecase/errors/exceptions.dart';
import 'package:nasa_clean_arch/core/usecase/errors/failures.dart';
import 'package:nasa_clean_arch/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_clean_arch/features/data/models/space_media_model.dart';
import 'package:nasa_clean_arch/features/data/repositories/space_media_repository_implementation.dart';

class MockSpaceMediaDatasource extends Mock implements ISpaceMediaDatasource {}

void main() {
  late SpaceMediaRepositoryImplementation repository;
  late ISpaceMediaDatasource datasource;

  setUp(() {
    datasource = MockSpaceMediaDatasource();
    repository = SpaceMediaRepositoryImplementation(datasource);
  });

  const tSpaceMediaModel = SpaceMediaModel(
    description: ' example',
    mediaType: 'image',
    title: 'title example',
    mediaUrl: 'https://example.com/image.png',
  );

  final tDate = DateTime(2022, 1, 28);

  test('should return space media model when calls the datasource', () async {
    when(() => datasource.getSpaceMediaFromDate(tDate)).thenAnswer(
      (_) async => tSpaceMediaModel,
    );
    final result = await repository.getSpaceMediaFromDate(tDate);

    expect(result, const Right(tSpaceMediaModel));
  });

  test(
      'should return a server failure when the call to datasource is unsucessful',
      () async {
    when(() => datasource.getSpaceMediaFromDate(tDate))
        .thenThrow(ServerException());
    final result = await repository.getSpaceMediaFromDate(tDate);

    expect(
      result,
      Left(ServerFailure()),
    );
  });
}
