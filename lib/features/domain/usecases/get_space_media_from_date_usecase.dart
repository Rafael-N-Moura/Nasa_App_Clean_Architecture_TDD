import 'package:dartz/dartz.dart';
import 'package:nasa_app_clean_architecture_tdd/core/usecase/usecase.dart';

import '../../../core/errors/failures.dart';
import '../entities/space_media_entity.dart';
import '../repositories/space_media_repository.dart';

class GetSpaceMediaFromDateUsecase
    implements Usecase<SpaceMediaEntity, DateTime> {
  final ISpaceMediaRepository repository;

  GetSpaceMediaFromDateUsecase(this.repository);

  @override
  Future<Either<Failure, SpaceMediaEntity>> call(DateTime date) async {
    return await repository.getSpaceMediaFromDate(date);
  }
}
