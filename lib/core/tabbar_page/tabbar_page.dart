import 'package:flutter/cupertino.dart';
import 'package:flutter_ai_chat/common/design/app_colors.dart';
import 'package:flutter_ai_chat/common/preview/app_preview.dart';
import 'package:flutter_ai_chat/core/chats_page/chats_page.dart';
import 'package:flutter_ai_chat/core/explore_page/explore_page.dart';
import 'package:flutter_ai_chat/core/profile_page/profile_page.dart';

class TabbarPage extends StatefulWidget {
  const TabbarPage({super.key});

  @override
  State<TabbarPage> createState() => _TabbarPageState();
}

class _TabbarPageState extends State<TabbarPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: AppColors.primary,
        inactiveColor: AppColors.textHint,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.eye),
            activeIcon: Icon(CupertinoIcons.eye_fill),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.bubble_left_bubble_right),
            activeIcon: Icon(CupertinoIcons.bubble_left_bubble_right_fill),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            activeIcon: Icon(CupertinoIcons.person_fill),
            label: 'Profile',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) => switch (_TabbarItem.values[index]) {
            _TabbarItem.explore => const ExplorePage(),
            _TabbarItem.chats => const ChatsPage(),
            _TabbarItem.profile => const ProfilePage(),
          },
        );
      },
    );
  }
}

enum _TabbarItem { explore, chats, profile }

@AppPagePreview(group: 'TabbarPage', name: 'TabbarPage')
Widget tabbarPagePreview() => const TabbarPage();
