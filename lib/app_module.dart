import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_app_clean_architecture_tdd/core/http_client/http_client.dart';
import 'package:nasa_app_clean_architecture_tdd/core/http_client/http_implementation.dart';
import 'package:nasa_app_clean_architecture_tdd/core/utils/date_input_converter.dart';
import 'package:nasa_app_clean_architecture_tdd/features/data/datasources/space_media_datasource_implementation.dart';
import 'package:nasa_app_clean_architecture_tdd/features/data/repositories/space_media_repository_implementation.dart';
import 'package:nasa_app_clean_architecture_tdd/features/domain/usecases/get_space_media_from_date_usecase.dart';
import 'package:nasa_app_clean_architecture_tdd/features/presentation/controllers/home_store.dart';
import 'package:http/http.dart' as http;

import 'features/presentation/pages/home_page.dart';
import 'features/presentation/pages/picture_page.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => GetSpaceMediaFromDateUsecase(i())),
        Bind((i) => SpaceMediaRepositoryImplementation(i())),
        Bind((i) => NasaDatasourceImplementation(i())),
        Bind((i) => http.Client()),
        Bind((i) => HttpImplementation()),
        Bind((i) => DateInputConverter()),
        Bind((i) => HomeStore(usecase: i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => HomePage()),
        ChildRoute('/picture',
            child: (context, args) => PicturePage.fromArgs(args.data)),
      ];
}
