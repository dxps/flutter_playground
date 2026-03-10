sealed class LoadUnloadImageEvent {}

final class LoadButtonPressedEvent extends LoadUnloadImageEvent {
  final String imageUrl;

  LoadButtonPressedEvent({required this.imageUrl});
}

final class RemoveButtonPressedEvent extends LoadUnloadImageEvent {}
