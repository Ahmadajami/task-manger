part of 'login_cubit.dart';

enum LoginStatus { initial, signingIn, failure }

extension LoginStatusExtensions on LoginStatus {
  bool get isSigningIn => this == LoginStatus.signingIn;
}

enum SignInMethod { none, emailPassword }

extension SignInMethodExtensions on SignInMethod {
  bool get isEmailPassword => this == SignInMethod.emailPassword;

}

final class LoginState extends Equatable {
  const LoginState._({
    this.status = LoginStatus.initial,
    this.signInMethod = SignInMethod.none,
    this.failure = UserFailure.none,
  });

  const LoginState.initial() : this._();

  const LoginState.signingWithEmailAndPassword()
      : this._(
    status: LoginStatus.signingIn,
    signInMethod: SignInMethod.emailPassword,
  );




  const LoginState.failure(UserFailure failure)
      : this._(
    status: LoginStatus.failure,
    failure: failure,
  );

  final LoginStatus status;
  final SignInMethod signInMethod;
  final UserFailure failure;

  @override
  List<Object> get props => [status, signInMethod, failure];
}

extension LoginStateExtensions on LoginState {
  bool get isFailure => status == LoginStatus.failure;

  bool get isSigningIn =>
      status.isSigningIn && signInMethod.isEmailPassword;
}
