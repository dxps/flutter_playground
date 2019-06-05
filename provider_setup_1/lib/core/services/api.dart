import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../models/post.dart';
import '../models/comment.dart';

/// The service responsible for networking requests
class Api {
  //
  static const endpoint = 'https://jsonplaceholder.typicode.com';

  var client = new http.Client();

  Future<User> getUserProfile(int userId) async {
    // Get user profile for id
    var response = await client.get('$endpoint/users/$userId');
    // Convert and return
    return User.fromJson(json.decode(response.body));
  }

  Future<List<Post>> getPostsForUser(int userId) async {
    var posts = List<Post>();
    // Get user posts for id
    var response = await client.get('$endpoint/posts?userId=$userId');
    // parse into List
    var parsed = json.decode(response.body) as List<dynamic>;

    // loop and convert each item to Post
    for (var post in parsed) {
      posts.add(Post.fromJson(post));
    }

    return posts;
  }

  Future<List<Comment>> getCommentsForPost(int postId) async {
    // Get comments for post
    var response = await client.get('$endpoint/comments?postId=$postId');
    // Parse into List
    var parsed = json.decode(response.body) as List<dynamic>;
    var comments = List<Comment>();
    // Loop and convert each item to a Comment
    for (var comment in parsed) {
      comments.add(Comment.fromJson(comment));
    }
    return comments;
  }
  //
}
