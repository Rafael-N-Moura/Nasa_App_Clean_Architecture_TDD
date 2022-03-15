import 'package:nasa_app_clean_architecture_tdd/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_app_clean_architecture_tdd/features/data/models/space_media_model.dart';

class SpaceMediaDatasourceImplementation implements ISpaceMediaDatasource {
  @override
  Future<SpaceMediaModel> getSpaceMediaFromDate(DateTime date) {
    // TODO: implement getSpaceMediaFromDate
    throw UnimplementedError();
  }
}
