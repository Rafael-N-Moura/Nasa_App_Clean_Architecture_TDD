import 'package:dartz/dartz.dart';

import 'package:nasa_app_clean_architecture_tdd/core/errors/failures.dart';
import 'package:nasa_app_clean_architecture_tdd/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_app_clean_architecture_tdd/features/domain/entities/space_media_entity.dart';
import 'package:nasa_app_clean_architecture_tdd/features/domain/repositories/space_media_repository.dart';

import '../../../core/errors/exceptions.dart';

class SpaceMediaRepositoryImplementation implements ISpaceMediaRepository {
  final ISpaceMediaDatasource datasource;

  SpaceMediaRepositoryImplementation(
    this.datasource,
  );

  @override
  Future<Either<Failure, SpaceMediaEntity>> getSpaceMediaFromDate(
      DateTime date) async {
    try {
      final result = await datasource.getSpaceMediaFromDate(date);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
