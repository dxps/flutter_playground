import 'package:flutter/material.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import '../models/item.dart';
import '../models/draggingmode.dart';

///
/// A list item that is wrapped in an ReorderableItem.
///
class ItemWidget extends StatelessWidget {
  //

  final Item data;
  final bool isFirst, isLast; // These attributes affect border drawn during dragging.
  final DraggingMode draggingMode;

  ItemWidget({this.data, this.isFirst, this.isLast, this.draggingMode});

  @override
  Widget build(BuildContext context) {
    //
    return ReorderableItem(key: data.key, childBuilder: _buildChild);
    //
  }

  Widget _buildChild(BuildContext context, ReorderableItemState state) {
    //
    BoxDecoration decoration;

    if (state == ReorderableItemState.dragProxy || state == ReorderableItemState.dragProxyFinished) {
      // slightly transparent background white dragging (just like on iOS)
      decoration = BoxDecoration(color: Color(0xD0FFFFFF));
    } else {
      bool placeholder = state == ReorderableItemState.placeholder;
      decoration = BoxDecoration(
          border: Border(
            top: isFirst && !placeholder ? Divider.createBorderSide(context) : BorderSide.none,
            bottom: isLast && placeholder ? BorderSide.none : Divider.createBorderSide(context),
          ),
          color: placeholder ? null : Colors.white);
    }

    // For iOS dragging mode, there will be drag handle on the right that triggers
    // reordering. For android mode it will be just an empty container.
    Widget dragHandle = draggingMode == DraggingMode.iOS
        ? ReorderableListener(
            child: Container(
              padding: EdgeInsets.only(right: 18.0, left: 18.0),
              color: Color(0x08000000),
              child: Center(child: Icon(Icons.reorder, color: Color(0xFF888888))),
            ),
          )
        : Container();

    Widget content = Container(
      decoration: decoration,
      child: SafeArea(
          top: false,
          bottom: false,
          child: Opacity(
            // hide content for placeholder
            opacity: state == ReorderableItemState.placeholder ? 0.0 : 1.0,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 14.0),
                      child: Text(data.title, style: Theme.of(context).textTheme.subhead),
                    ),
                  ),
                  // Triggers the reordering
                  dragHandle,
                ],
              ),
            ),
          )),
    );

    // For android dragging mode, wrap the entire content in DelayedReorderableListener
    if (draggingMode == DraggingMode.Android) {
      content = DelayedReorderableListener(child: content);
    }

    return content;
    //
  }

  //
}
