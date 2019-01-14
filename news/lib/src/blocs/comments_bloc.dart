import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

//
class CommentsBloc {
  //

  final _repo = Repository();
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  CommentsBloc() {
    _commentsFetcher.stream.transform(_commentsTransformer()).pipe(_commentsOutput);
  }

  // Streams Getters

  Observable<Map<int, Future<ItemModel>>> get itemWithComments => _commentsOutput.stream;

  // Sink

  Function(int) get fetchItemWithComments => _commentsFetcher.sink.add;

  _commentsTransformer() {
    //
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
        // the accumulator
        (Map<int, Future<ItemModel>> cache, int id, int index) {
          print ('_commentsTransformer > index=$index');
      cache[id] = _repo.fetchItem(id);
      cache[id].then((ItemModel item) {
        item.kids.forEach((kidId) => fetchItemWithComments(kidId));
      });
      return cache;
    }, <int, Future<ItemModel>>{
      // the seed (inited as an empty map, it will be used as a cache)
    });
  }

  dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }

  //
}
