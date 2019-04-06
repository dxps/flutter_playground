import 'package:flutter/material.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';

import '../models/item.dart';
import '../models/draggingmode.dart';
import '../widgets/item_wdg.dart';

///
/// The `HomeScreen`.
///
class HomeScreen extends StatefulWidget {
  //

  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();

  //
}

///
/// The state of `HomeScreen`.
///
class _HomeScreenState extends State<HomeScreen> {
  //

  List<Item> _items;

  DraggingMode _draggingMode = DraggingMode.iOS;

  _HomeScreenState() {
    //
    _items = List();
    for (int i = 0; i < 500; ++i) {
      String label = "List item $i";
      if (i == 5) {
        label += ". This item has a long label and will be wrapped.";
      }
      _items.add(Item(label, ValueKey(i)));
    }
    //
  }

  /// Returns the index of item with given key.
  ///
  int _indexOfKey(Key key) {
    return _items.indexWhere((Item d) => d.key == key);
  }

  //
  bool _onReorder(Key itemKey, Key newPositionKey) {
    //
    int draggedIndex = _indexOfKey(itemKey);
    Item draggedItem = _items[draggedIndex];
    int newPositionIndex = _indexOfKey(newPositionKey);

    // Uncomment to allow only even target reorder possition
    // if (newPositionIndex % 2 == 1)
    //   return false;

    setState(() {
      debugPrint("Reordering itemKey:$itemKey to newPositionKey:$newPositionKey");
      _items.removeAt(draggedIndex);
      _items.insert(newPositionIndex, draggedItem);
    });
    return true;
    //
  }

  void _onReorderDone(Key itemKey) {
    final draggedItem = _items[_indexOfKey(itemKey)];
    debugPrint("Reordering finished for ${draggedItem.title}}");
  }

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      body: ReorderableList(
        onReorder: this._onReorder,
        onReorderDone: this._onReorderDone,
        child: CustomScrollView(
          // cacheExtent: 3000,
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              expandedHeight: 100.0,
              flexibleSpace: const FlexibleSpaceBar(title: const Text('Demo')),
              actions: <Widget>[
                PopupMenuButton<DraggingMode>(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text("Options"),
                  ),
                  initialValue: _draggingMode,
                  onSelected: (DraggingMode mode) {
                    setState(() {
                      _draggingMode = mode;
                    });
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuItem<DraggingMode>>[
                        const PopupMenuItem<DraggingMode>(
                            value: DraggingMode.iOS, child: Text('iOS-like dragging')),
                        const PopupMenuItem<DraggingMode>(
                            value: DraggingMode.Android, child: Text('Android-like dragging')),
                      ],
                ),
              ],
            ),
            SliverPadding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return ItemWidget(
                      data: _items[index],
                      isFirst: index == 0,
                      isLast: index == _items.length - 1,
                      draggingMode: _draggingMode,
                    );
                  },
                  childCount: _items.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    //
  }

  //
}
