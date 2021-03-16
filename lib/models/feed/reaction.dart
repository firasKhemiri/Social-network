import 'package:flutter_login/models/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reaction.g.dart';

enum ReactionType { like, heart, admire, surprised, hate }

@JsonSerializable(explicitToJson: true)
class Reaction {
  Reaction({
    this.id,
    required this.user,
    required this.reactionType,
  });

  factory Reaction.fromJson(Map<String, dynamic> json) =>
      _$ReactionFromJson(json);
  Map<String, dynamic> toJson() => _$ReactionToJson(this);

  final int? id;
  final User user;
  final int reactionType;
}
