import 'package:flutter_bloc/flutter_bloc.dart';

import 'load_image_event.dart';
import 'load_image_state.dart';

class LoadUnloadImageBloc extends Bloc<LoadUnloadImageEvent, LoadImageState> {
  LoadUnloadImageBloc() : super(ImageNotLoadedState()) {
    on<LoadButtonPressedEvent>((event, emit) async {
      emit(ImageLoadingState());
      await Future.delayed(const Duration(milliseconds: 500));
      emit(ImageLoadedState());
    });
    on<RemoveButtonPressedEvent>((event, emit) async {
      emit(ImageNotLoadedState());
    });
  }
}
