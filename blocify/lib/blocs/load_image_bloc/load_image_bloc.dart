import 'package:flutter_bloc/flutter_bloc.dart';

import '../../image_data.dart';
import '../../models/my_image.dart';
import 'load_image_event.dart';
import 'load_image_state.dart';

class LoadUnloadImageBloc extends Bloc<LoadUnloadImageEvent, LoadImageState> {
  LoadUnloadImageBloc() : super(ImageNotLoadedState()) {
    on<LoadButtonPressedEvent>((event, emit) async {
      emit(ImageLoadingState());
      var fetchedImages = await Future.delayed(
        const Duration(milliseconds: 500),
        () {
          return imageData;
        },
      );
      var resultImages = fetchedImages.map((image) => MyImage.fromJson(image)).toList();
      emit(ImageLoadedState(images: resultImages));
    });
    on<RemoveButtonPressedEvent>((event, emit) async {
      emit(ImageNotLoadedState());
    });
  }
}
