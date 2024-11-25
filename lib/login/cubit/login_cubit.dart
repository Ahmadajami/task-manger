import 'package:app_core/app_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const LoginState.initial());

  final UserRepository _userRepository;

  Future<void> signInWithEmailAndPassword(SignInForm form) async {
    try {
      emit(const LoginState.signingWithEmailAndPassword());
      await _userRepository.login(form);
    } on UserFailure catch (failure) {
      _onLoginFailed(failure);
    }
  }

  void _onLoginFailed(UserFailure failure) {
    emit(LoginState.failure(failure));
    emit(const LoginState.initial());
  }
}
