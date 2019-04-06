import 'package:flutter/widgets.dart';

///
/// The data that used by a list item.
///
class Item {
  //

  final Key key; // Each item in reorderable list needs a stable and unique key.

  final String title;

  Item(this.title, this.key);

  //
}
