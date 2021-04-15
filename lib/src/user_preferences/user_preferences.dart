import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = new UserPreferences._internal();

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._internal();

  SharedPreferences _sharedPrefs;

  initPrefs() async {
    this._sharedPrefs = await SharedPreferences.getInstance();
  }

  get username {
    return _sharedPrefs.getString('username') ?? '';
  }

  set username(String value) {
    _sharedPrefs.setString('username', value);
  }

  get tokenId {
    return _sharedPrefs.getString('tokenId') ?? '';
  }

  set tokenId(String value) {
    _sharedPrefs.setString('tokenId', value);
  }

  get lastPage {
    return _sharedPrefs.getString('lastPage') ?? 'login';
  }

  set lastPage(String value) {
    _sharedPrefs.setString('lastPage', value);
  }
}
