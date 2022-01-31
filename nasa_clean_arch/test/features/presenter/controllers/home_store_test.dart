import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_arch/core/usecase/errors/failures.dart';
import 'package:nasa_clean_arch/features/domain/usecases/get_space_media_from_date_usecase.dart';
import 'package:nasa_clean_arch/features/presenter/controllers/home_store.dart';

import '../../../mocks/date_mock.dart';
import '../../../mocks/space_media_entity_mock.dart';

class MockGetSpaceMediaUsecaseFromDateUsecase extends Mock
    implements GetSpaceMediaUsecaseFromDateUsecase {}

void main() {
  late HomeStore store;
  late GetSpaceMediaUsecaseFromDateUsecase mockUsecase;

  setUp(() {
    mockUsecase = MockGetSpaceMediaUsecaseFromDateUsecase();
    store = HomeStore(mockUsecase);
  });

  test('should return a SpaceMedia from the usecase', () async {
    when(() => mockUsecase(any())).thenAnswer(
      (_) async => const Right(tSpaceMedia),
    );
    await store.getSpaceMediaFromDate(tDate);
    store.observer(onState: (state) {
      expect(state, tSpaceMedia);
      verify(() => mockUsecase(tDate)).called(1);
    });
  });

  final tFailure = ServerFailure();

  test('should return a Failure from the usecase when there is an error',
      () async {
    when(() => mockUsecase(any())).thenAnswer(
      (_) async => Left(tFailure),
    );
    await store.getSpaceMediaFromDate(tDate);
    store.observer(onError: (error) {
      expect(error, tFailure);
      verify(() => mockUsecase(tDate)).called(1);
    });
  });
}
