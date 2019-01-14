import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

final NewsDbProvider dbProvider = NewsDbProvider();

//
class Repository {
  //

  List<Source> sources = <Source>[
    dbProvider,
    NewsApiProvider(),
  ];

  List<Cache> caches = <Cache>[
    dbProvider,
  ];

  Future<List<int>> fetchTopIds() {
    //
    // Fow now, just use the second provider (api provider)
    // as db provider does not implemented it yet.
    return sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    //
    ItemModel item;
    Source source;
    for (source in sources) {
      item = await source.fetchItem(id);
      if (item != null) {
        break; // item found, exit the for loop
      }
    }
    for (var cache in caches) {
      cache.addItem(item);
    }
    return item;
  }

  clearCache() async {
    for (var cache in caches) {
      await cache.clear();
    }
  }

  //
}

///
abstract class Source {
  //

  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

///
abstract class Cache {
  //

  Future<int> addItem(ItemModel item);
  Future<int> clear();

}
