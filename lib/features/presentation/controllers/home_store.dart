import 'package:flutter_triple/flutter_triple.dart';
import 'package:nasa_app_clean_architecture_tdd/features/domain/entities/space_media_entity.dart';
import 'package:nasa_app_clean_architecture_tdd/features/domain/usecases/get_space_media_from_date_usecase.dart';

import '../../../core/errors/failures.dart';

class HomeStore extends NotifierStore<Failure, SpaceMediaEntity> {
  final GetSpaceMediaFromDateUsecase _usecase;
  HomeStore({required GetSpaceMediaFromDateUsecase usecase})
      : _usecase = usecase,
        super(const SpaceMediaEntity(
            description: '', mediaType: '', title: '', mediaUrl: null));

  getSpaceMediaFromDate(DateTime? date) async {
    setLoading(true);
    final result = await _usecase(date);
    result.fold((error) => setError(error), (sucess) => update(sucess));
    setLoading(false);
  }
}
