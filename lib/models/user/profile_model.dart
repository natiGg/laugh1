import 'package:json_annotation/json_annotation.dart';
import 'package:laugh1/models/user/user_model.dart';
part 'profile_model.g.dart';

@JsonSerializable()
class UserProfile {
  int id;
  User user;
  String name;
  String phone_number;
  String profile_pic;
  DateTime bod;
  String gender;
  String level;
  String bio;
  UserProfile(
      {required this.id,
      required this.user,
      required this.name,
      required this.phone_number,
      required this.profile_pic,
      required this.gender,
      required this.bio,
      required this.bod,
      required this.level});
  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}
