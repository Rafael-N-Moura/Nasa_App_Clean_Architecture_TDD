import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_app_clean_architecture_tdd/core/errors/failures.dart';
import 'package:nasa_app_clean_architecture_tdd/features/domain/entities/space_media_entity.dart';
import 'package:nasa_app_clean_architecture_tdd/features/domain/repositories/space_media_repository.dart';
import 'package:nasa_app_clean_architecture_tdd/features/domain/usecases/get_space_media_from_date_usecase.dart';

import '../../../mocks/date_mock.dart';

class MockSpaceMediaRepository extends Mock implements ISpaceMediaRepository {}

void main() {
  late GetSpaceMediaFromDateUsecase usecase;
  late ISpaceMediaRepository repository;

  setUp(() {
    repository = MockSpaceMediaRepository();
    usecase = GetSpaceMediaFromDateUsecase(repository);
  });

  const tSpaceMedia = SpaceMediaEntity(
    description: 'test description',
    mediaType: 'image',
    title: 'test title',
    mediaUrl: 'test mediaUrl',
  );

  test('should get space media entity for a given date from the repository',
      () async {
    when(() => repository.getSpaceMediaFromDate(tDate))
        .thenAnswer((_) async => const Right(tSpaceMedia));

    final result = await usecase(tDate);

    expect(result, const Right(tSpaceMedia));

    verify(() => repository.getSpaceMediaFromDate(tDate)).called(1);
  });

  test('should return a ServerFailure when don\'t succeed', () async {
    when(() => repository.getSpaceMediaFromDate(tDate))
        .thenAnswer((_) async => Left(ServerFailure()));

    final result = await usecase(tDate);

    expect(result, Left(ServerFailure()));

    verify(() => repository.getSpaceMediaFromDate(tDate)).called(1);
  });

  test('should return a NullParamFailure when receives a null param', () async {
    final result = await usecase(null);

    expect(result, Left(NullParamFailure()));

    verifyNever(() => repository.getSpaceMediaFromDate(tDate));
  });
}
