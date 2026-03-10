import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../image_data.dart';
import '../../models/my_image.dart';
import 'load_image_event.dart';
import 'load_image_state.dart';

class LoadUnloadImageBloc extends Bloc<LoadUnloadImageEvent, LoadImageState> {
  LoadUnloadImageBloc() : super(ImageNotLoadedState()) {
    on<LoadButtonPressedEvent>((event, emit) async {
      // emit(ImageLoadingState());
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

  // --------------------------------------------------------------------------
  // Overriding some methods so that we can observe the standard flow which is:
  // onEvent > onTransition > onChange > onError
  // --------------------------------------------------------------------------

  @override
  void onChange(Change<LoadImageState> change) {
    super.onChange(change);
    debugPrint("onChange Observer: currentState=${change.currentState}  nextState=${change.nextState}");
  }

  @override
  void onTransition(Transition<LoadUnloadImageEvent, LoadImageState> transition) {
    // FYI: This is called before a BLoC state has been updated, so it is invoked before `onChange()`.
    super.onTransition(transition);
    debugPrint("onTransition Observer: currentState=${transition.currentState}  nextState=${transition.nextState}");
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    // FYI: This is called whenever an error occurs.
    super.onError(error, stackTrace);
    debugPrint("onError Observer: error=$error");
  }

  @override
  void onEvent(LoadUnloadImageEvent event) {
    // FYI: This is called whenever an event is added to the BLoC.
    super.onEvent(event);
    debugPrint("onEvent Observer: event=$event");
  }
}
