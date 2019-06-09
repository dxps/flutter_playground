import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_setup_1/core/models/user.dart';
import 'package:provider_setup_1/ui/shared/app_colors.dart';
import 'package:provider_setup_1/ui/shared/text_styles.dart';
import 'package:provider_setup_1/ui/shared/ui_helper.dart';
import '../../core/models/post.dart';
import 'comments_view.dart';

///
class PostView extends StatelessWidget {
  //
  final Post post;

  PostView({this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            UIHelper.verticalSpaceLarge(),
            Text(post.title, style: headerStyle),
            Text('by ${Provider.of<User>(context).name}', style: TextStyle(fontSize: 9.0)),
            UIHelper.verticalSpaceMedium(),
            Text(post.body),
            Comments(post.id)
          ],
        ),
      ),
    );
  }
  //
}
