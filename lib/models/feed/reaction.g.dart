// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reaction _$ReactionFromJson(Map json) {
  return Reaction(
    id: json['id'] as int?,
    user: User.fromJson(Map<String, dynamic>.from(json['user'] as Map)),
    reactionType: json['reactionType'] as int,
  );
}

Map<String, dynamic> _$ReactionToJson(Reaction instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user.toJson(),
      'reactionType': instance.reactionType,
    };
