import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  User({
    required this.id,
    this.username,
    required this.firstName,
    required this.lastName,
    this.bio,
    this.email,
    this.birthday,
    this.gender,
    this.phone,
    required this.picture,
    this.coverPicture,
    this.followersCount,
    this.followingCount,
    this.isComplete,
    // this.followers,
    // this.following,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  static final generic = User(
    id: 1,
    username: 'firs_km',
    firstName: 'Firas',
    lastName: 'Khemir',
    // bio: 'Wazzzup bitches',
    // email: 'firas.khemiri@esprit.tn',
    // gender: 'Male',
    // birthday: DateTime(1995, 04, 21),
    picture: '',
    // followersCount: 20,
    // followingCount: 2,
    // followers: [],
    // following: []
  );

  final int id;
  String? username;
  String firstName;
  String lastName;
  String? bio;
  final String? email;
  DateTime? birthday;
  final String? gender;
  String picture;
  String? coverPicture;
  String? phone;
  bool? isComplete;

  int? followersCount;
  int? followingCount;

  // List<User>? followers;
  // List<User>? following;

  String getFullName() {
    return '$firstName $lastName';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
