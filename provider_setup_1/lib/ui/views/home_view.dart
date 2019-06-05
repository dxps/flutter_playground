import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_setup_1/core/models/user.dart';
import 'package:provider_setup_1/core/viewmodels/home_model.dart';
import 'package:provider_setup_1/ui/shared/app_colors.dart';

import 'base_view.dart';

class HomeView extends StatelessWidget {
  //

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
      onModelReady: (model) {
        model.getPosts(Provider.of<User>(context).id);
      },
      builder: (context, model, child) => Scaffold(
            backgroundColor: backgroundColor,
            body: Column(),
          ),
    );
  }

  //
}
