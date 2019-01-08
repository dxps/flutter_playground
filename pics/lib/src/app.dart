import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' show get;
import 'package:http/http.dart' show Response;

import './models/image_model.dart';
import './widgets/image_list.dart';

//
class App extends StatefulWidget {
  //

  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

//
class _AppState extends State<App> {
  //

  int _counter = 0;
  List<ImageModel> _images = [];

  //
  @override
  Widget build(BuildContext context) {
    //

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Let\'s see some images'),
        ),
        body: ImageList(_images),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: _fetchImage,
        ),
      ),
    );
  }

  //
  void _fetchImage() async {
    //

    _counter++;
    Response response = await get('http://jsonplaceholder.typicode.com/photos/$_counter');
    ImageModel image = ImageModel.fromJson(json.decode(response.body));

    setState(() {
      _images.add(image);
    });
  }
}
