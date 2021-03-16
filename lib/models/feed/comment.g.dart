// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map json) {
  return Comment(
    id: json['id'] as int,
    user: User.fromJson(Map<String, dynamic>.from(json['user'] as Map)),
    content: json['content'] as String,
    dateCreated: DateTime.parse(json['dateCreated'] as String),
    reactions: (json['reactions'] as List<dynamic>)
        .map((e) => Reaction.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList(),
  );
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'user': instance.user.toJson(),
      'dateCreated': instance.dateCreated.toIso8601String(),
      'reactions': instance.reactions.map((e) => e.toJson()).toList(),
    };
