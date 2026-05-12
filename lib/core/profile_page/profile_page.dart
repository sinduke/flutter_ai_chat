import 'package:flutter/cupertino.dart';
import 'package:flutter_ai_chat/common/preview/app_preview.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Profile')),
      child: Center(
        child: Text(key: ValueKey('profile-page-title'), 'Profile'),
      ),
    );
  }
}

@AppPagePreview(group: 'TabbarPage', name: 'ProfilePage')
Widget profilePagePreview() => const ProfilePage();
