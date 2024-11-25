
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';


part 'sign_in_form.g.dart';


@JsonSerializable()
class SignInForm  extends Equatable{

  const SignInForm({
    required this.username,
    required this.password,
    this.expiresInMins,
  });

  factory SignInForm.fromJson(Map<String, dynamic> json) =>
      _$SignInFormFromJson(json);

  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'password')
  final String password;
  @JsonKey(name: 'expiresInMins')
  final int? expiresInMins;

  Map<String, dynamic> toJson() => _$SignInFormToJson(this);

  @override

  List<Object?> get props => [username,password];
}
