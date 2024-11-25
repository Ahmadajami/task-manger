

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';


@JsonSerializable()
class UserModel extends Equatable {

  const UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
    required this.accessToken,
    required this.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'firstName')
  final String firstName;
  @JsonKey(name: 'lastName')
  final String lastName;
  @JsonKey(name: 'gender')
  final String gender;
  @JsonKey(name: 'image')
  final String image;
  @JsonKey(name: 'accessToken')
  final String accessToken;
  @JsonKey(name: 'refreshToken')
  final String refreshToken;

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props => [
    id,
    username,
    email,
    firstName,
    lastName,
    gender,
    image,
    accessToken,
    refreshToken,
  ];

  static const none = UserModel(id: 0,
      username: 'none',
      email: 'none',
      firstName: 'none',
      lastName: 'none',
      gender:'none',
      image:'none',
      accessToken: 'none',
      refreshToken: 'none',);
}
extension UserExtensions on UserModel {
  bool get isNone => this == UserModel.none;
}
