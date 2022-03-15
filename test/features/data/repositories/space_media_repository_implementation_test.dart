import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_app_clean_architecture_tdd/core/errors/exceptions.dart';
import 'package:nasa_app_clean_architecture_tdd/core/errors/failures.dart';
import 'package:nasa_app_clean_architecture_tdd/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_app_clean_architecture_tdd/features/data/models/space_media_model.dart';
import 'package:nasa_app_clean_architecture_tdd/features/data/repositories/space_media_repository_implementation.dart';

class MockSpaceMediaDatasource extends Mock implements ISpaceMediaDatasource {}

void main() {
  late SpaceMediaRepositoryImplementation repository;
  late ISpaceMediaDatasource datasource;

  setUp(() {
    datasource = MockSpaceMediaDatasource();
    repository = SpaceMediaRepositoryImplementation(datasource);
  });

  final tSpaceMediaModel = SpaceMediaModel(
    description: 'test description',
    mediaType: 'image',
    title: 'test title',
    mediaUrl: 'test mediaUrl',
  );

  final tDate = DateTime(2022, 03, 14);

  test('should return space media model when calls the datasource', () async {
    when(() => datasource.getSpaceMediaFromDate(tDate))
        .thenAnswer((_) async => tSpaceMediaModel);

    final result = await repository.getSpaceMediaFromDate(tDate);

    expect(result, Right(tSpaceMediaModel));

    verify(() => datasource.getSpaceMediaFromDate(tDate)).called(1);
  });

  test(
      'should return a server failure when the call to datasource is unsucessful',
      () async {
    when(() => datasource.getSpaceMediaFromDate(tDate))
        .thenThrow(ServerException());

    final result = await repository.getSpaceMediaFromDate(tDate);

    expect(result, Left(ServerFailure()));

    verify(() => datasource.getSpaceMediaFromDate(tDate)).called(1);
  });
}
