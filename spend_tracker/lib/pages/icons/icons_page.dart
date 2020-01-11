import 'package:flutter/material.dart';
import 'package:spend_tracker/pages/icons/icon_list.dart';

class IconsPage extends StatelessWidget {
  //
  const IconsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).primaryColor;
    return Container(
      child: Scaffold(
        appBar: AppBar(title: const Text('Icons')),
        body: SingleChildScrollView(
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: icons
                .map(
                  (iconData) => InkWell(
                    child: Opacity(
                      opacity: .7,
                      child: Icon(iconData, size: 60, color: color),
                    ),
                    onTap: () {
                      Navigator.of(context).pop<IconData>(iconData);
                    },
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
