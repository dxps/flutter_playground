sealed class LoadImageState {}

final class ImageNotLoadedState extends LoadImageState {}

final class ImageLoadingState extends LoadImageState {}

final class ImageLoadedState extends LoadImageState {
  final String imageUrl;

  ImageLoadedState({required this.imageUrl});
}
