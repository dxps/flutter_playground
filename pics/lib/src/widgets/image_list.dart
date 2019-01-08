import 'package:flutter/material.dart';
import '../models/image_model.dart';

//
class ImageList extends StatelessWidget {
  //

  final List<ImageModel> _images;

  ImageList(this._images);

  //
  @override
  Widget build(BuildContext context) {
    //

    return ListView.builder(
      itemCount: _images.length,
      itemBuilder: (BuildContext ctx, int index) {
        return _buildImage(_images[index]);
      },
    );
  }

  //
  Widget _buildImage(ImageModel image) {
    //

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: Column(
        children: <Widget>[
          Padding(
            child: Image.network(image.url),
            padding: EdgeInsets.only(bottom: 16.0),
          ),
          Text(image.title),
        ],
      ),
    );
  }
}
