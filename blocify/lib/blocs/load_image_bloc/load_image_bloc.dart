import 'package:flutter_bloc/flutter_bloc.dart';

import 'load_image_event.dart';
import 'load_image_state.dart';

class LoadUnloadImageBloc extends Bloc<LoadUnloadImageEvent, LoadImageState> {
  LoadUnloadImageBloc() : super(ImageNotLoadedState()) {
    on<LoadButtonPressedEvent>((event, emit) async {
      emit(ImageLoadingState());
      await Future.delayed(const Duration(milliseconds: 500));
      String resultImage = event.imageUrl;
      emit(ImageLoadedState(imageUrl: resultImage));
    });
    on<RemoveButtonPressedEvent>((event, emit) async {
      emit(ImageNotLoadedState());
    });
  }
}
