import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/my_image.dart';
import '../states/images_state.dart';
import '../utils/images_data.dart';

class ImagesCubit extends Cubit<ImagesState> {
  ImagesCubit() : super(ImagesNotLoadedState());

  Future<void> loadImages() async {
    emit(ImagesLoadingState());

    var fetchedImages = await Future.delayed(const Duration(seconds: 1), () {
      return imagesStore;
    });

    var resultImages = fetchedImages.map((image) => MyImage.fromJson(image)).toList();

    emit(ImagesLoadedState(images: resultImages));
  }

  void unloadImages() async {
    emit(ImagesNotLoadedState());
  }
}
