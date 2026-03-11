import 'package:equatable/equatable.dart';

import '../../models/my_image.dart';

sealed class ImagesState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class ImageNotLoadedState extends ImagesState {}

final class ImageLoadingState extends ImagesState {}

final class ImageLoadedState extends ImagesState {
  final List<MyImage> images;

  ImageLoadedState({required this.images});

  @override
  List<Object?> get props => [images];
}
