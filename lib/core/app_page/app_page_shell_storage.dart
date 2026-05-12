import 'package:shared_preferences/shared_preferences.dart';

abstract interface class AppPageShellStorage {
  Future<bool> loadShowTabBar();

  Future<void> saveShowTabBar(bool showTabBar);
}

final class SharedPreferencesAppPageShellStorage
    implements AppPageShellStorage {
  SharedPreferencesAppPageShellStorage({SharedPreferencesAsync? preferences})
    : _preferences = preferences ?? SharedPreferencesAsync();

  static const showTabBarKey = 'app_page.show_tab_bar';

  final SharedPreferencesAsync _preferences;

  @override
  Future<bool> loadShowTabBar() async {
    return await _preferences.getBool(showTabBarKey) ?? false;
  }

  @override
  Future<void> saveShowTabBar(bool showTabBar) {
    return _preferences.setBool(showTabBarKey, showTabBar);
  }
}
