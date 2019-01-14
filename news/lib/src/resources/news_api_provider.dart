import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client;

import '../models/item_model.dart';
import 'repository.dart';

final String _endpointRoot = 'https://hacker-news.firebaseio.com/v0';

//
class NewsApiProvider implements Source {
  //

  Client client = Client();

  Future<List<int>> fetchTopIds() async {
    //
    final response = await client.get('$_endpointRoot/topstories.json');
    return json.decode(response.body).cast<int>();
  }

  Future<ItemModel> fetchItem(int id) async {
    //
    // print('(dbg) [NewsApiProvider] fetchItem($id) > Getting $_endpointRoot/item/$id.json ');
    final response = await client.get('$_endpointRoot/item/$id.json');
    final responseBody = response.body;
    // print('(dbg) [NewsApiProvider] fetchItem($id) > response.body=$responseBody');
    final parsedJson = json.decode(responseBody);
    return ItemModel.fromJson(parsedJson);
  }

  //
}
