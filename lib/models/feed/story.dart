import 'package:flutter_login/models/feed/bucket.dart';
import 'package:flutter_login/models/feed/pub_image.dart';
import 'package:flutter_login/models/user/bucket.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:timeago/timeago.dart' as timeago;

part 'story.g.dart';

@JsonSerializable(explicitToJson: true)
class Story {
  Story({
    required this.id,
    required this.image,
    required this.user,
    required this.dateCreated,
    this.reactions,
    this.comments,
  });

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);
  Map<String, dynamic> toJson() => _$StoryToJson(this);

  static final generic = Story(
      id: 1,
      image: PubImage.generic,
      user: User.generic,
      dateCreated: DateTime.now(),
      reactions: [],
      comments: []);

  final int id;
  final PubImage image;
  final User user;
  final DateTime dateCreated;

  List<Reaction>? reactions;
  List<Comment>? comments;

  String timeAgo() {
    final now = DateTime.now();
    return timeago.format(now.subtract(now.difference(dateCreated)));
  }

  void addReaction(User user, {int reactionType = 0}) {
    reactions!.add(Reaction(user: user, reactionType: reactionType));
  }
}
