import 'package:flutter/widgets.dart';

///
/// The data that used by a list item.
///
class ItemData {
  //

  final String title;
  final Key key; // Each item in reorderable list needs a stable and unique key.

  ItemData(this.title, this.key);

  //
}
