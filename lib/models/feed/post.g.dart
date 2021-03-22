// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map json) {
  return Post(
    id: json['id'] as int,
    description: json['description'] as String,
    user: User.fromJson(Map<String, dynamic>.from(json['user'] as Map)),
    dateCreated: DateTime.parse(json['dateCreated'] as String),
    reactions: (json['reactions'] as List<dynamic>)
        .map((e) => Reaction.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList(),
    commentCount: json['commentCount'] as int,
    location: json['location'] as String?,
  )
    ..images = (json['images'] as List<dynamic>?)
        ?.map((e) => PubImage.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList()
    ..comments = (json['comments'] as List<dynamic>?)
        ?.map((e) => Comment.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'user': instance.user.toJson(),
      'dateCreated': instance.dateCreated.toIso8601String(),
      'reactions': instance.reactions.map((e) => e.toJson()).toList(),
      'comments': instance.comments?.map((e) => e.toJson()).toList(),
      'commentCount': instance.commentCount,
      'location': instance.location,
    };
