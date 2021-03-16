import 'package:json_annotation/json_annotation.dart';

part 'pub_image.g.dart';

@JsonSerializable(explicitToJson: true)
class PubImage {
  PubImage({this.id, required this.path});

  factory PubImage.fromJson(Map<String, dynamic> json) =>
      _$PubImageFromJson(json);
  Map<String, dynamic> toJson() => _$PubImageToJson(this);

  static var generic = PubImage(id: 1, path: '');

  final int? id;
  final String path;
}
