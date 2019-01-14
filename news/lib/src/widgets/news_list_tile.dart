import 'dart:async';
import 'package:flutter/material.dart';

import '../models/item_model.dart';
import '../blocs/stories_provider.dart';
import 'loading_container.dart';

//
class NewsListTile extends StatelessWidget {
  //

  final int itemId;

  const NewsListTile(this.itemId);

  @override
  Widget build(BuildContext context) {
    //

    final bloc = StoriesProvider.of(context);

    return StreamBuilder<Map<int, Future<ItemModel>>>(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }
        return FutureBuilder(
            future: snapshot.data[itemId],
            builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
              if (!itemSnapshot.hasData) {
                return LoadingContainer();
              }
              return _buildTile(itemSnapshot.data);
            });
      },
    );
  }

  Widget _buildTile(ItemModel item) {
    //
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(item.title),
          subtitle: Text('${item.score} votes'),
          trailing: Column(
            children: <Widget>[Icon(Icons.comment), Text('${item.descendants ?? 0}')],
          ),
        ),
        Divider(height: 6.0,)
      ],
    );
  }

  //
}
