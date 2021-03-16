import 'package:flutter_login/models/feed/bucket.dart';

class Feed {
  Feed({
    required this.posts,
    required this.stories,
  });

  static final generic = Feed(
      posts: [Post.generic, Post.generic],
      stories: [Story.generic, Story.generic]);

  List<Post> posts;
  List<Story> stories;
}
