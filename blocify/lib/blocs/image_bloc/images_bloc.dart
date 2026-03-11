import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../images_data.dart';
import '../../models/my_image.dart';
import 'images_event.dart';
import 'images_state.dart';

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  ImagesBloc() : super(ImageNotLoadedState()) {
    on<LoadButtonPressedEvent>((event, emit) async {
      emit(ImageLoadingState());
      var fetchedImages = await Future.delayed(
        const Duration(seconds: 1),
        () {
          return imagesStore;
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
  void onChange(Change<ImagesState> change) {
    super.onChange(change);
    debugPrint("onChange Observer: currentState=${change.currentState}  nextState=${change.nextState}");
  }

  @override
  void onTransition(Transition<ImagesEvent, ImagesState> transition) {
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
  void onEvent(ImagesEvent event) {
    // FYI: This is called whenever an event is added to the BLoC.
    super.onEvent(event);
    debugPrint("onEvent Observer: event=$event");
  }
}
