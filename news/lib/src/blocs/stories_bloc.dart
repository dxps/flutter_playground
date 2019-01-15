import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

//
class StoriesBloc {
  //

  final _repo = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _itemsFetcher = PublishSubject<int>();
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  // --- Streams Getters ---

  /// The stream of top stories ids.
  Observable<List<int>> get topIds => _topIds.stream;

  /// The stream of eventually received items.
  Observable<Map<int, Future<ItemModel>>> get items => _itemsOutput.stream;

  // --- Sinks Getters ---

  /// fetchItem(itemId) submits the provided item id to items fetcher. Nothing is returned.
  Function(int) get fetchItem => _itemsFetcher.sink.add;

  StoriesBloc() {
    _itemsFetcher.stream.transform(_itemsTransformer()).pipe(_itemsOutput);
  }

  fetchTopIds() async {
    final ids = await _repo.fetchTopIds();
    _topIds.sink.add(ids);
  }

  clearCache() {
    return _repo.clearCache();
  }

  _itemsTransformer() {
    return ScanStreamTransformer(
      // the accumulator (in cache)
      (Map<int, Future<ItemModel>> cache, int id, int index) {
        //
        // print('StoriesBloc > _itemsTransformer > index $index | id $id');
        cache[id] = _repo.fetchItem(id);
        return cache;
      },
      // the seed (of cache)
      <int, Future<ItemModel>>{}, // inited as an empty map
    );
  }

  dispose() {
    _topIds.close();
    _itemsFetcher.close();
    _itemsOutput.close();
  }

  //
}
