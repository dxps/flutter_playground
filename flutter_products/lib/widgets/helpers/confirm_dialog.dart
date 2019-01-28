import 'package:flutter/material.dart';

showDeleteConfirmDialog(BuildContext context) {
  //
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Are you sure?'),
        content: Text('This action cannot be undone!'),
        actions: <Widget>[
          FlatButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text('Confirm'),
            onPressed: () {
              Navigator.pop(context); // close this dialog first
              Navigator.pop(context, true); // then go back to the previous page
            },
          )
        ],
      );
    },
  );
}
