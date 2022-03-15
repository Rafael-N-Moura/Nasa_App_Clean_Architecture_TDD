import 'package:dartz/dartz.dart';
import 'package:nasa_app_clean_architecture_tdd/features/domain/entities/space_media_entity.dart';

import '../../../core/errors/failures.dart';

abstract class ISpaceMediaRepository {
  Future<Either<Failure, SpaceMediaEntity>> getSpaceMediaFromDate(
      DateTime date);
}
