import 'package:provider_setup_1/core/models/comment.dart';
import 'package:provider_setup_1/core/services/api.dart';
import 'package:provider_setup_1/core/viewmodels/base_model.dart';
import 'package:provider_setup_1/locator.dart';

///
///
///
class CommentsModel extends BaseModel {
  //
  Api _api = locator<Api>();

  List<Comment> comments;

  Future fetchComments(int postId) async {
    setState(ViewState.Busy);
    comments = await _api.getCommentsForPost(postId);
    setState(ViewState.Idle);
  }
  //
}
