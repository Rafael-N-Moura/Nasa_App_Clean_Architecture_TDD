import 'package:nasa_app_clean_architecture_tdd/features/domain/entities/space_media_entity.dart';

class SpaceMediaModel extends SpaceMediaEntity {
  SpaceMediaModel(
      {required String description,
      required String mediaType,
      required String title,
      required String? mediaUrl})
      : super(
          description: description,
          mediaType: mediaType,
          title: title,
          mediaUrl: mediaUrl,
        );

  factory SpaceMediaModel.fromJson(Map<String, dynamic> json) =>
      SpaceMediaModel(
        description: json['explanation'],
        mediaType: json['media_type'],
        title: json['title'],
        mediaUrl: json['url'],
      );
}
