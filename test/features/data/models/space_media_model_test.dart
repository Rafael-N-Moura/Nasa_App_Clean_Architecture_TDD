import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_app_clean_architecture_tdd/features/data/models/space_media_model.dart';
import 'package:nasa_app_clean_architecture_tdd/features/domain/entities/space_media_entity.dart';

import '../../../mocks/space_media_mock.dart';

void main() {
  final tSpaceMediaModel = SpaceMediaModel(
    description:
        "Pictured -- a very scenic road to the stars.  The road approaches La Silla Observatory in Chile, with the ESO's 3.6-meter telescope just up ahead. To the left are some futuristic-looking support structures for the planned BlackGEM telescopes, an array of optical telescopes that will help locate optical counterparts to gravitational waves detections by LIGO and other detectors.  But there is much more. Red airglow illuminates the night sky on the right, while the central band of our Milky Way Galaxy slants across the image center. Jupiter can be seen just above the band near the image center, while Saturn is visible just above the 3.6-meter telescope dome. The two largest satellite galaxies of our Milky Way Galaxy, the LMC and SMC, are seen on the far right. The featured image panorama was built up from multiple 15-second exposures that were captured on 2019 June 30.  Two days later, La Silla experienced a rare total eclipse of the Sun.",
    mediaType: "image",
    title: "A Road to the Stars",
    mediaUrl:
        "https://apod.nasa.gov/apod/image/2203/Road2Stars_EsoHoralek_1080.jpg",
  );

  test('should be a subclass of SpaceMediaEntity', () {
    expect(tSpaceMediaModel, isA<SpaceMediaEntity>());
  });

  test('should return a valid model', () {
    final Map<String, dynamic> jsonMap = json.decode(spaceMediaMock);

    final result = SpaceMediaModel.fromJson(jsonMap);

    expect(result, tSpaceMediaModel);
  });
}
