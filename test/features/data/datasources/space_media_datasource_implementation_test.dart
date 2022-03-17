import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_app_clean_architecture_tdd/core/errors/exceptions.dart';
import 'package:nasa_app_clean_architecture_tdd/core/http_client/http_client.dart';
import 'package:nasa_app_clean_architecture_tdd/core/http_client/http_implementation.dart';
import 'package:nasa_app_clean_architecture_tdd/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_app_clean_architecture_tdd/features/data/datasources/space_media_datasource_implementation.dart';
import 'package:nasa_app_clean_architecture_tdd/features/data/models/space_media_model.dart';

import '../../../mocks/date_mock.dart';
import '../../../mocks/space_media_mock.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  late ISpaceMediaDatasource datasource;
  late HttpClient client;

  setUp(() {
    client = HttpClientMock();
    datasource = NasaDatasourceImplementation(client);
  });

  final urlExpected =
      'https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&date=2022-03-14';

  sucessMock() {
    when(() => client.get(any())).thenAnswer(
      (_) async => HttpAnswer(data: spaceMediaMock, statusCode: 200),
    );
  }

  test('should call the get method with correct url', () async {
    sucessMock();

    await datasource.getSpaceMediaFromDate(tDate);

    verify((() => client.get(urlExpected))).called(1);
  });

  test('should return a SpaceMediaModel when is successful', () async {
    sucessMock();

    final tSpaceMeiaModelExpected = SpaceMediaModel(
      description:
          "Pictured -- a very scenic road to the stars.  The road approaches La Silla Observatory in Chile, with the ESO's 3.6-meter telescope just up ahead. To the left are some futuristic-looking support structures for the planned BlackGEM telescopes, an array of optical telescopes that will help locate optical counterparts to gravitational waves detections by LIGO and other detectors.  But there is much more. Red airglow illuminates the night sky on the right, while the central band of our Milky Way Galaxy slants across the image center. Jupiter can be seen just above the band near the image center, while Saturn is visible just above the 3.6-meter telescope dome. The two largest satellite galaxies of our Milky Way Galaxy, the LMC and SMC, are seen on the far right. The featured image panorama was built up from multiple 15-second exposures that were captured on 2019 June 30.  Two days later, La Silla experienced a rare total eclipse of the Sun.",
      mediaType: "image",
      title: "A Road to the Stars",
      mediaUrl:
          "https://apod.nasa.gov/apod/image/2203/Road2Stars_EsoHoralek_1080.jpg",
    );

    final result = await datasource.getSpaceMediaFromDate(tDate);

    expect(result, tSpaceMeiaModelExpected);
  });

  test('should throw a ServerException when the call is unsuccessful', () {
    when(() => client.get(any())).thenAnswer(
        (invocation) async => HttpAnswer(data: 'data', statusCode: 800));

    final result = datasource.getSpaceMediaFromDate(tDate);

    expect(() => result, throwsA(ServerException()));
  });
}
