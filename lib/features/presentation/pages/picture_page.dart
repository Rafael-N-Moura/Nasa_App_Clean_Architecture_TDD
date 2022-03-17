import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:nasa_app_clean_architecture_tdd/features/presentation/controllers/home_store.dart';

import '../../domain/entities/space_media_entity.dart';
import '../widgets/custom_video_player.dart';
import '../widgets/description_bottom_sheet.dart';
import '../widgets/image_network_with_loader.dart';
import '../widgets/page_slider_up.dart';

class PicturePage extends StatefulWidget {
  late final DateTime? dateSelected;

  PicturePage({
    Key? key,
    this.dateSelected,
  }) : super(key: key);

  PicturePage.fromArgs(dynamic arguments, {Key? key}) : super(key: key) {
    dateSelected = arguments['dateSelected'];
  }

  static void navigate(DateTime? dateSelected) {
    Modular.to.pushNamed(
      '/picture',
      arguments: {'dateSelected': dateSelected},
    );
  }

  @override
  _PicturePageState createState() => _PicturePageState();
}

class _PicturePageState extends ModularState<PicturePage, HomeStore> {
  @override
  void initState() {
    super.initState();
    store.getSpaceMediaFromDate(widget.dateSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ScopedBuilder(
        store: store,
        onLoading: (context) =>
            const Center(child: CircularProgressIndicator()),
        onError: (context, error) => Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Um erro ocorreu, por favor volte para tela inicial e tente novamente mais tarde',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ),
        onState: (context, SpaceMediaEntity spaceMedia) {
          return PageSliderUp(
            onSlideUp: () => showDescriptionBottomSheet(
              context: context,
              title: spaceMedia.title,
              description: spaceMedia.description,
            ),
            child: spaceMedia.mediaType == 'video' &&
                    spaceMedia.mediaUrl != null
                ? CustomVideoPlayer(spaceMedia)
                : spaceMedia.mediaType == 'image' && spaceMedia.mediaUrl != null
                    ? ImageNetworkWithLoader(spaceMedia.mediaUrl!)
                    : Container(),
          );
        },
      ),
    );
  }
}
