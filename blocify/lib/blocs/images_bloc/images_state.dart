import 'package:equatable/equatable.dart';

import '../../models/my_image.dart';

sealed class ImagesState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class ImagesNotLoadedState extends ImagesState {}

final class ImagesLoadingState extends ImagesState {}

final class ImagesLoadedState extends ImagesState {
  final List<MyImage> images;

  ImagesLoadedState({required this.images});

  @override
  List<Object?> get props => [images];
}
