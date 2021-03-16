// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Story _$StoryFromJson(Map json) {
  return Story(
    id: json['id'] as int,
    image: PubImage.fromJson(Map<String, dynamic>.from(json['image'] as Map)),
    creator: User.fromJson(Map<String, dynamic>.from(json['creator'] as Map)),
    dateCreated: DateTime.parse(json['dateCreated'] as String),
    reactions: (json['reactions'] as List<dynamic>)
        .map((e) => Reaction.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList(),
    comments: (json['comments'] as List<dynamic>)
        .map((e) => Comment.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList(),
  );
}

Map<String, dynamic> _$StoryToJson(Story instance) => <String, dynamic>{
      'id': instance.id,
      'image': instance.image.toJson(),
      'creator': instance.creator.toJson(),
      'dateCreated': instance.dateCreated.toIso8601String(),
      'reactions': instance.reactions.map((e) => e.toJson()).toList(),
      'comments': instance.comments.map((e) => e.toJson()).toList(),
    };
