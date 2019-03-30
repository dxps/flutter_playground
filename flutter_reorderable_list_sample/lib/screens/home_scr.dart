import 'package:flutter/material.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import '../models/itemdata.dart';
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

  List<ItemData> _items;

  DraggingMode _draggingMode = DraggingMode.iOS;

  _HomeScreenState() {
    //
    _items = List();
    for (int i = 0; i < 500; ++i) {
      String label = "List item $i";
      if (i == 5) {
        label += ". This item has a long label and will be wrapped.";
      }
      _items.add(ItemData(label, ValueKey(i)));
    }
    //
  }

  /// Returns the index of item with given key.
  int _indexOfKey(Key key) {
    return _items.indexWhere((ItemData d) => d.key == key);
  }

  //
  bool _onReorder(Key item, Key newPosition) {
    //
    int draggingIndex = _indexOfKey(item);
    int newPositionIndex = _indexOfKey(newPosition);

    // Uncomment to allow only even target reorder possition
    // if (newPositionIndex % 2 == 1)
    //   return false;

    final draggedItem = _items[draggingIndex];
    setState(() {
      debugPrint("Reordering $item -> $newPosition");
      _items.removeAt(draggingIndex);
      _items.insert(newPositionIndex, draggedItem);
    });
    return true;
    //
  }

  void _onReorderDone(Key item) {
    final draggedItem = _items[_indexOfKey(item)];
    debugPrint("Reordering finished for ${draggedItem.title}}");
  }

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
                    return Item(
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
