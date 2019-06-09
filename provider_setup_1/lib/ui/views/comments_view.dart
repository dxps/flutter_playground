import 'package:flutter/material.dart';
import 'package:provider_setup_1/core/viewmodels/base_model.dart';
import 'package:provider_setup_1/core/viewmodels/comments_model.dart';
import 'package:provider_setup_1/ui/views/base_view.dart';
import 'package:provider_setup_1/ui/widgets/comments.dart';

///
///
///
class Comments extends StatelessWidget {
  //
  final int postId;

  Comments(this.postId);

  @override
  Widget build(BuildContext context) {
    return BaseView<CommentsModel>(
      onModelReady: (model) => model.fetchComments(postId),
      builder: (context, model, child) => model.state == ViewState.Busy
          ? Center(child: CircularProgressIndicator())
          : Expanded(
              child: ListView(
              children: model.comments.map((comment) => CommentItem(comment)).toList(),
            )),
    );
  }

  //
}
