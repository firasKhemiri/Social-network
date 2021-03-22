import 'package:flutter_login/models/feed/pub_image.dart';
import 'package:flutter_login/models/user/user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'comment.dart';
import 'reaction.dart';

part 'post.g.dart';

@JsonSerializable(explicitToJson: true)
class Post {
  Post({
    required this.id,
    required this.description,
    // this.images,
    required this.user,
    required this.dateCreated,
    // required this.dateUpdated,
    required this.reactions,
    // this.comments,
    required this.commentCount,
    this.location,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);

  static var generic = Post(
      id: 1,
      description: 'generic',
      user: User.generic,
      dateCreated: DateTime.now(),
      // dateUpdated: DateTime.now(),
      reactions: [],
      commentCount: 12);

  final int id;
  String description;
  List<PubImage>? images;
  final User user;
  final DateTime dateCreated;
  // DateTime dateUpdated;

  List<Reaction> reactions;
  List<Comment>? comments;
  int commentCount;
  String? location;

  String timeAgo() {
    final now = DateTime.now();
    return timeago.format(now.subtract(now.difference(dateCreated)));
  }

  bool isReactedBy(User user) {
    return reactions.any((reaction) => reaction.user == user);
  }

  void toggleReactionFor(User user, {int reactionType = 0}) {
    if (isReactedBy(user)) {
      reactions.removeWhere((reaction) => reaction.user == user);
    } else {
      reactions.add(Reaction(user: user, reactionType: reactionType));
    }
  }
}
