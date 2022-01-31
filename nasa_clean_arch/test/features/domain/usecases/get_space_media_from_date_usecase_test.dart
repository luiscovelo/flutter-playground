import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_arch/core/usecase/errors/failures.dart';
import 'package:nasa_clean_arch/core/usecase/usecase.dart';
import 'package:nasa_clean_arch/features/domain/entities/space_media_entity.dart';
import 'package:nasa_clean_arch/features/domain/repositories/space_media_repository.dart';
import 'package:nasa_clean_arch/features/domain/usecases/get_space_media_from_date_usecase.dart';

class MockSpaceMediaRepository extends Mock implements ISpaceMediaRepository {}

void main() {
  late GetSpaceMediaUsecaseFromDateUsecase usecase;
  late ISpaceMediaRepository repository;

  setUp(() {
    repository = MockSpaceMediaRepository();
    usecase = GetSpaceMediaUsecaseFromDateUsecase(repository);
  });

  const tSpaceMedia = SpaceMediaEntity(
    description: 'description example',
    mediaType: 'image',
    title: 'title example',
    mediaUrl: 'https://image.example.com/image.png',
  );

  final tDate = DateTime(2022, 1, 28);

  test('should get space media for a given date from the repository', () async {
    when(() => repository.getSpaceMediaFromDate(tDate)).thenAnswer(
      (_) async => const Right<Failure, SpaceMediaEntity>(tSpaceMedia),
    );

    final result = await usecase(tDate);
    expect(result, const Right(tSpaceMedia));
    verify(() => repository.getSpaceMediaFromDate(tDate));
  });

  test('should return a Failure when dont succeed', () async {
    when(() => repository.getSpaceMediaFromDate(tDate)).thenAnswer(
      (_) async => Left<Failure, SpaceMediaEntity>(ServerFailure()),
    );

    final result = await usecase(tDate);
    expect(result, Left(ServerFailure()));
  });

  test('should return a NullParamFailure when receivers a null param',
      () async {
    final result = await usecase(null);
    expect(result, Left(NullParamFailure()));
    verifyNever(() => repository.getSpaceMediaFromDate(tDate));
  });
}
