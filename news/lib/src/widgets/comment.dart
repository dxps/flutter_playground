import 'dart:async';
import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../widgets/loading_container.dart';

//
class Comment extends StatelessWidget {
  //

  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  const Comment({this.itemId, this.itemMap, this.depth: 1});

  @override
  Widget build(BuildContext context) {
    //
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }
        final item = snapshot.data;
        var children = <Widget>[];
        if (item.by == "") // if the item was deleted
          children.add(Container(
            alignment: Alignment.centerLeft,
            child: Text('====', style: TextStyle(color: Colors.grey)),
            padding: EdgeInsets.only(left: 18.0),
          ));
        else
          children.add(ListTile(
            title: _buildText(item),
            subtitle: Text(item.by),
            contentPadding: EdgeInsets.only(left: depth * 16.0, right: 16.0),
          ));
        children.add(Divider());

        snapshot.data.kids.forEach((kitId) {
          children.add(Comment(itemId: kitId, itemMap: itemMap, depth: depth + 1));
        });

        return Column(
          children: children,
        );
      },
    );
  }

  Widget _buildText(ItemModel item) {
    //
    final text = item.text
        .replaceAll('&#x27;', '\'')
        .replaceAll('<p>', '\n\n')
        .replaceAll('</p>', '')
        .replaceAll('&quot;', '"');
    return Text(text);
  }
}
