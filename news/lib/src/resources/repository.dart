import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

//
class Repository {
  //

  NewsDbProvider dbProvider = NewsDbProvider();
  NewsApiProvider apiProvider = NewsApiProvider();

  Future<List<int>> fetchTopIds() {
    //
    // Just returning the API result, no cache used here.
    return apiProvider.fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    //
    var item = await dbProvider.fetchItem(id);
    if (item != null) {
      return item; // the cached entry found
    }
    item = await apiProvider.fetchItem(id);
    dbProvider.addItem(item);
    return item;
  }

  //
}
