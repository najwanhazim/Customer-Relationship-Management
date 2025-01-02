import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  @JsonKey(ignore: true)
  final String? id;

  final String login_id;
  final String email;
  final String full_name;

  @JsonKey(ignore: true)
  final String? password;

  @JsonKey(ignore: true)
  final String? salt;

  @JsonKey(ignore: true)
  final DateTime? password_expiry;

  @JsonKey(ignore: true)
  final String? team_id;

  @JsonKey(ignore: true)
  final int? user_type;

  User(
      {this.id,
      required this.login_id,
      required this.email,
      required this.full_name,
      this.password,
      this.salt,
      this.password_expiry,
      this.team_id,
      this.user_type});

  Map<String, dynamic> toJson() => _$UserToJson(this);

  static List<User> fromJsonList(List<dynamic> dataList) {
    return dataList.map((data) => User.fromJson(data)).toList();
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String?,
      login_id: json['login_id'] as String,
      email: json['email'] as String,
      full_name: json['full_name'] as String,
      password: json['password'] as String?,
      salt: json['salt'] as String?,
      password_expiry: json['password_expiry'] != null
          ? DateTime.parse(json['password_expiry'] as String)
          : null,
      team_id: json['team_id'] as String?,
      user_type: json['user_type'] as int,
    );
  }
}
