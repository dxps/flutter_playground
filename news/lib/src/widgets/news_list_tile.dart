import 'dart:async';
import 'package:flutter/material.dart';

import '../models/item_model.dart';
import '../blocs/stories_provider.dart';

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
          return Text('Loading ...');
        }
        return FutureBuilder(
            future: snapshot.data[itemId],
            builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
              if (!itemSnapshot.hasData) {
                return Text('Loading item (id $itemId) ...');
              }
              return Text(itemSnapshot.data.title);
            });
      },
    );
  }

  //
}
