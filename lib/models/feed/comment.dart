import 'package:flutter_login/models/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

import 'reaction.dart';

part 'comment.g.dart';

@JsonSerializable(explicitToJson: true)
class Comment {
  Comment({
    required this.id,
    required this.user,
    required this.content,
    required this.dateCreated,
    // required this.dateUpdated,
    required this.reactions,
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);

  static var generic = Comment(
      id: 1, user: User.generic, content: 'yoo', dateCreated: DateTime.now(),
      // dateUpdated: DateTime.now(),
      reactions: []);

  final int id;
  String content;
  final User user;
  final DateTime dateCreated;
  // DateTime dateUpdated;
  List<Reaction> reactions;

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
