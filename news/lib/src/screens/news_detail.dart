import 'dart:async';
import 'package:flutter/material.dart';
import '../blocs/comments_provider.dart';
import '../models/item_model.dart';
import '../widgets/comments.dart';

//
class NewsDetail extends StatelessWidget {
  //

  final int itemId;

  const NewsDetail({this.itemId});

  @override
  Widget build(BuildContext context) {
    //
    final bloc = CommentsProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: _buildBody(bloc),
    );
  }

  Widget _buildBody(CommentsBloc bloc) {
    //
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        //
        if (!snapshot.hasData) {
          return Text('Loading ...');
        }
        final itemFuture = snapshot.data[itemId];
        return FutureBuilder(
          future: itemFuture,
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            //
            if (!itemSnapshot.hasData) {
              return Text('Loading ...');
            }
            return _buildList(itemSnapshot.data, snapshot.data);
          },
        );
      },
    );
  }

  Widget _buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    //
    final commentsList = item.kids.map((kidId) {
      return Comment(itemId: kidId, itemMap: itemMap);
    }).toList();
    final children = <Widget>[];
    children.add(_buildTitle(item));
    children.addAll(commentsList);
    return ListView(
      children: children,
    );
  }

  Widget _buildTitle(ItemModel item) {
    //
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 10.0),
      alignment: Alignment.topCenter,
      child: Text(
        item.title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  //
}
