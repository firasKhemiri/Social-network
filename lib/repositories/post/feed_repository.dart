import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter_login/common/graphql/graphql_config.dart';
import 'package:flutter_login/common/graphql/queries/bucket.dart';
import 'package:flutter_login/common/storage/secure_storage.dart';
import 'package:flutter_login/models/feed/bucket.dart';
import 'package:flutter_login/models/feed/feed.dart';
import 'package:flutter_login/repositories/user/user_repository.dart';

enum FeedStatus { loading, load, notloaded, loaded }

class FeedRepository {
  final _controller = StreamController<FeedStatus>();
  final _queryMutation = QueryMutation();
  final _userRepository = UserRepository();

  Stream<FeedStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    // yield FeedStatus.notloaded;
    yield* _controller.stream;
  }

  Future<Feed> getFeed() async {
    try {
      var token = await _userRepository.getToken();
      final client = GraphQLService(token);
      final result = await client.performQuery(_queryMutation.getPostsQuery());

      // log(result.data.toString());
      if (result.data.toString() == 'null') {
        log('null post from endpoint');
        throw Exception();
      } else {
        log('all good from endpoint');

        var postsData = result.data['posts'] as List<dynamic>;
        var storiesData = result.data['stories'] as List<dynamic>;

        var posts = _getPostsfromData(postsData);
        var stories = _getStoriesfromData(storiesData);

        _controller.add(FeedStatus.loaded);
        return Feed(posts: posts, stories: stories);
      }
    } catch (e) {
      log(e.toString());
      throw Exception('An issue occured');
    }
  }

  List<Post> _getPostsfromData(List<dynamic> data) {
    var posts = <Post>[];
    try {
      data.forEach((post) {
        // log('post data $post');
        // var codec = const JsonCodec();
        // var decoded = codec.decode('{"id": 1}');
        // var json = jsonDecode(post.toString()) as Map<String, dynamic>;

        // log('post data $decoded');
        posts.add(Post.fromJson(post as Map<String, dynamic>));
      });
      log('post: ${posts[0].id} ${posts[0].user.firstName}');
      return posts;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  List<Story> _getStoriesfromData(List<dynamic> data) {
    var stories = <Story>[];
    data.forEach((story) {
      stories.add(Story.fromJson(story as Map<String, dynamic>));
    });
    //   stories.add(Story.fromJson(story as Map<String, dynamic>));
    // });
    // log('story: ${stories[0].id} ${stories[0].user.firstName}');
    return stories;
  }

  void dispose() => _controller.close();
}
