// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map json) {
  return User(
    id: json['id'] as int,
    username: json['username'] as String?,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    bio: json['bio'] as String?,
    email: json['email'] as String?,
    birthday: json['birthday'] == null
        ? null
        : DateTime.parse(json['birthday'] as String),
    gender: json['gender'] as String?,
    phone: json['phone'] as String?,
    picture: json['picture'] as String,
    coverPicture: json['coverPicture'] as String?,
    followersCount: json['followersCount'] as int?,
    followingCount: json['followingCount'] as int?,
    isComplete: json['isComplete'] as bool?,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'bio': instance.bio,
      'email': instance.email,
      'birthday': instance.birthday?.toIso8601String(),
      'gender': instance.gender,
      'picture': instance.picture,
      'coverPicture': instance.coverPicture,
      'phone': instance.phone,
      'isComplete': instance.isComplete,
      'followersCount': instance.followersCount,
      'followingCount': instance.followingCount,
    };
