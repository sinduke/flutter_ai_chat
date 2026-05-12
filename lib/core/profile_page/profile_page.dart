import 'package:flutter/cupertino.dart';
import 'package:flutter_ai_chat/common/preview/app_preview.dart';
import 'package:flutter_ai_chat/core/settings_page/settings_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, this.onLogout});

  final VoidCallback? onLogout;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Profile'),
        trailing: CupertinoButton(
          key: const ValueKey('profile-page-settings-button'),
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          onPressed: () {
            Navigator.of(context).push(
              CupertinoPageRoute<void>(
                builder: (context) => SettingsPage(onLogout: onLogout),
              ),
            );
          },
          child: const Text('Settings'),
        ),
      ),
      child: const Center(
        child: Text(key: ValueKey('profile-page-title'), 'Profile'),
      ),
    );
  }
}

@AppPagePreview(group: 'TabbarPage', name: 'ProfilePage')
Widget profilePagePreview() => const ProfilePage();
