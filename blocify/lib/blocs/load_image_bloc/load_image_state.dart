import 'package:equatable/equatable.dart';

import '../../models/my_image.dart';

sealed class LoadImageState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class ImageNotLoadedState extends LoadImageState {}

final class ImageLoadingState extends LoadImageState {}

final class ImageLoadedState extends LoadImageState {
  final List<MyImage> images;

  ImageLoadedState({required this.images});

  @override
  List<Object?> get props => [images];
}
