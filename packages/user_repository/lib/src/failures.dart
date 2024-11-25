import 'package:app_core/app_core.dart';

class UserFailure extends Failure {
  const UserFailure._();
  factory UserFailure.fromAuthUserChanges() => const AuthUserChangesFailure();
  factory UserFailure.fromSignOut() => const SignOutFailure();
  factory UserFailure.fromSignIn()=> const SignInFailure();
  factory UserFailure.fromStorage()=> const StorageFailure();
  static const none = UserNoFailure();

}
class UserNoFailure extends UserFailure {
  const UserNoFailure() : super._();
}

class AuthUserChangesFailure extends UserFailure {
  const AuthUserChangesFailure() : super._();
}
class SignOutFailure extends UserFailure {
  const SignOutFailure() : super._();
}

class SignInFailure extends UserFailure {
  const SignInFailure() : super._();
}

class StorageFailure extends UserFailure{
  const StorageFailure(): super._();
}
