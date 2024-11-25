part of 'app_cubit.dart';

enum AppStatus {
  unauthenticated,
  authenticated,
  failure,
}

extension AppStatusExtensions on AppStatus {
  bool get isUnauthenticated => this == AppStatus.unauthenticated;
  bool get isAuthenticated => this == AppStatus.authenticated;
  bool get isFailure => this == AppStatus.failure;
}

final class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.user = UserModel.none,
    this.failure = UserFailure.none,
  });

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);



  const AppState.authenticated(UserModel user)
      : this._(
    status: AppStatus.authenticated,
    user: user,
  );

  const AppState.failure({
    required UserFailure failure,
    required UserModel user,
  }) : this._(
    status: AppStatus.failure,
    user: user,
    failure: failure,
  );

  final AppStatus status;
  final UserModel user;
  final UserFailure failure;

  @override
  List<Object?> get props => [status, user, failure];
}

extension AppStateExtensions on AppState {
  bool get isUnauthenticated => status.isUnauthenticated;
  bool get isAuthenticated => status.isAuthenticated;
  bool get isFailure => status.isFailure;
}
