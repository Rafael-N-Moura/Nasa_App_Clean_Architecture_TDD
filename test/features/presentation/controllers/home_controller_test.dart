import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_app_clean_architecture_tdd/core/errors/failures.dart';
import 'package:nasa_app_clean_architecture_tdd/features/domain/usecases/get_space_media_from_date_usecase.dart';
import 'package:nasa_app_clean_architecture_tdd/features/presentation/controllers/home_store.dart';

import '../../../mocks/date_mock.dart';
import '../../../mocks/space_media_entity_mock.dart';

class MockGetSpaceMediaFromDateUseCase extends Mock
    implements GetSpaceMediaFromDateUsecase {}

void main() {
  late HomeStore controller;
  late GetSpaceMediaFromDateUsecase mockUseCase;
  setUp(() {
    mockUseCase = MockGetSpaceMediaFromDateUseCase();
    controller = HomeStore(usecase:mockUseCase);
  });

  test('should return a SpaceMedia from the usecase', () async {
    when(() => mockUseCase(any()))
        .thenAnswer((invocation) async => const Right(tSpaceMedia));

    await controller.getSpaceMediaFromDate(tDate);

    controller.observer(onState: ((state) {
      expect(state, tSpaceMedia);
      verify(() => mockUseCase(tDate)).called(1);
    }));
  });

  final tFailure = ServerFailure();

  test('should return a ServerFailure from the usecase when there is an error',
      () async {
    when(() => mockUseCase(any()))
        .thenAnswer((invocation) async => Left(tFailure));

    await controller.getSpaceMediaFromDate(tDate);

    controller.observer(onError: ((error) {
      expect(error, tFailure);
      verify(() => mockUseCase(tDate)).called(1);
    }));
  });
}
