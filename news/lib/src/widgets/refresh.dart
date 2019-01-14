import 'package:flutter/material.dart';
import '../blocs/stories_provider.dart';

//
class Refresh extends StatelessWidget {
  //

  final Widget child;

  const Refresh({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    final StoriesBloc bloc = StoriesProvider.of(context);

    return RefreshIndicator(
      child: child,
      onRefresh: () async {
        await bloc.clearCache();
        await bloc.fetchTopIds();
      },
    );
  }

  //
}
