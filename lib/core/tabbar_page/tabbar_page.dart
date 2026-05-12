import 'package:flutter/cupertino.dart';
import 'package:flutter_ai_chat/common/design/app_colors.dart';
import 'package:flutter_ai_chat/common/preview/app_preview.dart';
import 'package:flutter_ai_chat/core/chats_page/chats_page.dart';
import 'package:flutter_ai_chat/core/explore_page/explore_page.dart';
import 'package:flutter_ai_chat/core/profile_page/profile_page.dart';

class TabbarPage extends StatefulWidget {
  const TabbarPage({super.key, this.onLogout});

  final VoidCallback? onLogout;

  @override
  State<TabbarPage> createState() => _TabbarPageState();
}

class _TabbarPageState extends State<TabbarPage> {
  static const _tabBarAnimationDuration = Duration(milliseconds: 240);
  static const _tabBarAnimationCurve = Curves.easeOutCubic;

  late final CupertinoTabController _tabController;
  late final List<_TabRouteObserver> _routeObservers;
  final List<int> _routeDepths = List<int>.filled(_TabbarItem.values.length, 0);

  int _currentIndex = 0;

  bool get _showsTabBar => _routeDepths[_currentIndex] <= 1;

  @override
  void initState() {
    super.initState();
    _tabController = CupertinoTabController();
    _tabController.addListener(_handleTabChanged);
    _routeObservers = List.generate(
      _TabbarItem.values.length,
      (index) => _TabRouteObserver(
        tabIndex: index,
        onDepthChanged: _handleRouteDepthChanged,
      ),
    );
  }

  @override
  void dispose() {
    _tabController
      ..removeListener(_handleTabChanged)
      ..dispose();
    super.dispose();
  }

  void _handleTabChanged() {
    if (_currentIndex == _tabController.index) {
      return;
    }

    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  void _handleRouteDepthChanged(int tabIndex, int depth) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _routeDepths[tabIndex] == depth) {
        return;
      }

      setState(() {
        _routeDepths[tabIndex] = depth;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabBar = CupertinoTabBar(
      currentIndex: _currentIndex,
      activeColor: AppColors.primary,
      inactiveColor: AppColors.textHint,
      onTap: (index) {
        _tabController.index = index;
      },
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
    );
    final tabBarHeight =
        tabBar.preferredSize.height + MediaQuery.viewPaddingOf(context).bottom;

    return Stack(
      children: [
        AnimatedPadding(
          duration: _tabBarAnimationDuration,
          curve: _tabBarAnimationCurve,
          padding: EdgeInsets.only(bottom: _showsTabBar ? tabBarHeight : 0),
          child: IndexedStack(
            index: _currentIndex,
            children: [
              for (final tab in _TabbarItem.values)
                TickerMode(
                  enabled: tab.index == _currentIndex,
                  child: _buildTabView(tab),
                ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: IgnorePointer(
            ignoring: !_showsTabBar,
            child: AnimatedSlide(
              duration: _tabBarAnimationDuration,
              curve: _tabBarAnimationCurve,
              offset: _showsTabBar ? Offset.zero : const Offset(0, 1),
              child: AnimatedOpacity(
                key: const ValueKey('tabbar-page-tabbar-opacity'),
                duration: _tabBarAnimationDuration,
                curve: _tabBarAnimationCurve,
                opacity: _showsTabBar ? 1 : 0,
                child: tabBar,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabView(_TabbarItem tab) {
    return CupertinoTabView(
      navigatorObservers: [_routeObservers[tab.index]],
      builder: (context) => switch (tab) {
        _TabbarItem.explore => const ExplorePage(),
        _TabbarItem.chats => const ChatsPage(),
        _TabbarItem.profile => ProfilePage(onLogout: widget.onLogout),
      },
    );
  }
}

final class _TabRouteObserver extends NavigatorObserver {
  _TabRouteObserver({required this.tabIndex, required this.onDepthChanged});

  final int tabIndex;
  final void Function(int tabIndex, int depth) onDepthChanged;

  int _depth = 0;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _depth += 1;
    _notify();
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _depth = _depth > 0 ? _depth - 1 : 0;
    _notify();
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _depth = _depth > 0 ? _depth - 1 : 0;
    _notify();
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (oldRoute == null && newRoute != null) {
      _depth += 1;
    } else if (oldRoute != null && newRoute == null) {
      _depth = _depth > 0 ? _depth - 1 : 0;
    }
    _notify();
  }

  void _notify() {
    onDepthChanged(tabIndex, _depth);
  }
}

enum _TabbarItem { explore, chats, profile }

@AppPagePreview(group: 'TabbarPage', name: 'TabbarPage')
Widget tabbarPagePreview() => const TabbarPage();
