import 'package:app_core/app_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(
        userRepository.currentUser.isNone
            ? const AppState.unauthenticated()
            : AppState.authenticated(userRepository.currentUser),
      ) {
    _watchUser();
  }

  final UserRepository _userRepository;

  @override
  Future<void> close() async {
    await _unwatchUser();
    return super.close();
  }

  Future<void> logOut() async {
    try {
      await _userRepository.logOut();
    } on UserFailure catch (failure) {
      _onUserFailed(failure);
    }
  }

  void _onUserChanged(UserRepositoryEvent user) {
    if (user.user.isNone) {
      emit(const AppState.unauthenticated());
    } else if (state.isUnauthenticated) {
      emit(AppState.authenticated(user.user));
    } else {
      emit(AppState.authenticated(user.user));
    }
  }

  void _onUserFailed(UserFailure failure) {
    final currentState = state;
    emit(AppState.failure(failure: failure, user: currentState.user));

  }

  late final StreamSubscription<UserRepositoryEvent> _userSubscription;
  void _watchUser() {
    _userSubscription = _userRepository.watchUser.listen(_onUserChanged);

  }

  Future<void> _unwatchUser() {
    _userRepository.dispose();
    return _userSubscription.cancel();

  }
}
