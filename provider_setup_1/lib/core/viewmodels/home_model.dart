import '../models/post.dart';
import '../services/api.dart';
import '../viewmodels/base_model.dart';
export '../enums/viewstate.dart';
import 'package:provider_setup_1/locator.dart';

///
class HomeModel extends BaseModel {
  //
  Api _api = locator<Api>();

  List<Post> posts;

  Future getPosts(int userId) async {
    setState(ViewState.Busy);
    posts = await _api.getPostsForUser(userId);
    setState(ViewState.Idle);
  }
  //
}
