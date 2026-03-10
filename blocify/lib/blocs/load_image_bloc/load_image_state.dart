import '../../models/my_image.dart';

sealed class LoadImageState {}

final class ImageNotLoadedState extends LoadImageState {}

final class ImageLoadingState extends LoadImageState {}

final class ImageLoadedState extends LoadImageState {
  final List<MyImage> images;

  ImageLoadedState({required this.images});
}
