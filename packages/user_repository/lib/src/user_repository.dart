
import 'package:api_client/api_client.dart';
import 'package:app_core/app_core.dart';
import 'package:user_repository/src/failures.dart';

class _UserRepositoryConstants {
  static const String userKey = 'auth';
}

class UserRepositoryEvent {
  UserRepositoryEvent(this.user);

  final UserModel user;
}

class UserRepository {
  UserRepository({
    required ApiClient client,
    StorageService? storage,
  })  : _client = client,
        _storageService = storage ?? StorageService(),
        _user = UserModel.none {
    _initialize();
  }

  final ApiClient _client;
  final StorageService _storageService;
  final StreamController<UserRepositoryEvent> _onChangeController =
  StreamController<UserRepositoryEvent>.broadcast();

  late UserModel _user;

  ///Sync User Getter
  UserModel get currentUser => _user;
  /// Stream User Getter
  Stream<UserRepositoryEvent> get watchUser => _onChangeController.stream;

  Future<void> _initialize() async {
    await _loadInitialUser();
  }

  Future<void> _loadInitialUser() async {
    try {
      final  storedUser = await _storageService.readData(
        _UserRepositoryConstants.userKey,
      );

      if (storedUser == null) {
        _updateUser(UserModel.none);
        return;
      }

      final userModel = UserModel.fromJson(
        jsonDecode(storedUser) as Map<String, dynamic>,
      );
      _updateUser(userModel);
    } catch (_) {
      _updateUser(UserModel.none);
      throw UserFailure.fromStorage();
    }
  }

  Future<void> login(SignInForm form) async {
    try {
      final  user = await _client.login(form);
      _updateUser(user);
      unawaited(
        _storageService.saveData(
          _UserRepositoryConstants.userKey,
          jsonEncode(user.toJson()),
        ),
      );
    } on DioException {
      throw UserFailure.fromSignIn();
    }
  }

  Future<void> logOut() async {
    try {
      _updateUser(UserModel.none);
      unawaited(
        _storageService.deleteData(_UserRepositoryConstants.userKey),
      );
    } catch (_) {
      throw UserFailure.fromSignOut();
    }
  }

  void _updateUser(UserModel user) {
    _user = user;
    _onChangeController.add(UserRepositoryEvent(user));
  }

  void dispose() {
    _onChangeController.close();
  }
}
