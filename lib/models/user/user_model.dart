import 'package:json_annotation/json_annotation.dart';
import 'package:laugh1/models/user/profile_model.dart';
part 'user_model.g.dart';

@JsonSerializable()
class User {
  String email;
  String username;
  String password;
  User({
    required this.email,
    required this.username,
    required this.password,
  });
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
