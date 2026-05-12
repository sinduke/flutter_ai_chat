import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_ai_chat/common/design/app_colors.dart';
import 'package:flutter_ai_chat/common/preview/app_preview.dart';
import 'package:flutter_ai_chat/core/app_page/app_page_shell_storage.dart';
import 'package:flutter_ai_chat/core/tabbar_page/tabbar_page.dart';
import 'package:flutter_ai_chat/core/welcome_page/welcome_page.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key, AppPageShellStorage? shellStorage})
    : _shellStorage = shellStorage;

  final AppPageShellStorage? _shellStorage;

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  late final AppPageShellStorage _shellStorage =
      widget._shellStorage ?? SharedPreferencesAppPageShellStorage();

  bool _showTabBar = false;
  bool _hasShellChangedBeforeRestore = false;

  @override
  void initState() {
    super.initState();
    unawaited(_restoreAppShell());
  }

  Future<void> _restoreAppShell() async {
    final showTabBar = await _shellStorage.loadShowTabBar();
    if (!mounted ||
        _hasShellChangedBeforeRestore ||
        showTabBar == _showTabBar) {
      return;
    }

    setState(() {
      _showTabBar = showTabBar;
    });
  }

  void _setShowTabBar(bool showTabBar) {
    _hasShellChangedBeforeRestore = true;

    setState(() {
      _showTabBar = showTabBar;
    });
    unawaited(_shellStorage.saveShowTabBar(showTabBar));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: AppPageBuilder(
        showTabBar: _showTabBar,
        tabBarView: TabbarPage(
          onLogout: () {
            _setShowTabBar(false);
          },
        ),
        onboardingView: WelcomePage(
          onOnboardingCompleted: () {
            _setShowTabBar(true);
          },
        ),
      ),
    );
  }
}

class AppPageBuilder extends StatelessWidget {
  const AppPageBuilder({
    super.key,
    required this.showTabBar,
    required this.tabBarView,
    required this.onboardingView,
  });

  static const _tabBarKey = ValueKey('app-page-builder-tabbar');
  static const _onboardingKey = ValueKey('app-page-builder-onboarding');

  final bool showTabBar;
  final Widget tabBarView;
  final Widget onboardingView;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: AnimatedSwitcher(
        duration: _AppPageTransition.duration,
        layoutBuilder: _AppPageTransition.layout,
        transitionBuilder: (child, animation) => _AppPageTransition.buildSlide(
          child: child,
          animation: animation,
          showTabBar: showTabBar,
          tabBarKey: _tabBarKey,
        ),
        child: showTabBar
            ? KeyedSubtree(key: _tabBarKey, child: tabBarView)
            : KeyedSubtree(key: _onboardingKey, child: onboardingView),
      ),
    );
  }
}

abstract final class _AppPageTransition {
  static const duration = Duration(milliseconds: 350);
  static const curve = Curves.easeInOutCubic;

  static Widget layout(Widget? currentChild, List<Widget> previousChildren) {
    return Stack(
      fit: StackFit.expand,
      children: [...previousChildren, ?currentChild],
    );
  }

  static Widget buildSlide({
    required Widget child,
    required Animation<double> animation,
    required bool showTabBar,
    required Key tabBarKey,
  }) {
    final isTabBarChild = child.key == tabBarKey;
    final beginOffset = _beginOffset(
      isIncoming: isTabBarChild == showTabBar,
      showTabBar: showTabBar,
    );
    final position = Tween<Offset>(
      begin: beginOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animation, curve: curve));

    return SlideTransition(position: position, child: child);
  }

  static Offset _beginOffset({
    required bool isIncoming,
    required bool showTabBar,
  }) {
    if (isIncoming) {
      return showTabBar ? const Offset(1, 0) : const Offset(-1, 0);
    }

    return showTabBar ? const Offset(-1, 0) : const Offset(1, 0);
  }
}

class _TabBarPlaceholder extends StatelessWidget {
  const _TabBarPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const _FullScreenPanel(
      backgroundColor: AppColors.error,
      label: 'Tabbar',
    );
  }
}

class _FullScreenPanel extends StatelessWidget {
  const _FullScreenPanel({required this.backgroundColor, required this.label});

  final Color backgroundColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: ColoredBox(
        color: backgroundColor,
        child: Center(
          child: Text(
            label,
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle
                .copyWith(
                  color: CupertinoColors.white,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      ),
    );
  }
}

@AppPagePreview(group: 'AppPage', name: 'AppPage')
Widget appPagePreview() {
  return AppPage(shellStorage: _MemoryAppPageShellStorage(showTabBar: false));
}

@AppPagePreview(group: 'AppPageBuilder', name: 'Onboarding')
Widget appPageBuilderOnboardingPreview() {
  return const AppPageBuilder(
    showTabBar: false,
    tabBarView: TabbarPage(),
    onboardingView: WelcomePage(),
  );
}

@AppPagePreview(group: 'AppPageBuilder', name: 'Tabbar')
Widget appPageBuilderTabbarPreview() {
  return const AppPageBuilder(
    showTabBar: true,
    tabBarView: TabbarPage(),
    onboardingView: WelcomePage(),
  );
}

@AppPagePreview(group: 'AppPage', name: 'Tabbar')
Widget tabBarPlaceholderPreview() => const _TabBarPlaceholder();

@AppPagePreview(group: 'AppPage', name: 'Panel')
Widget fullScreenPanelPreview() {
  return const _FullScreenPanel(
    backgroundColor: AppColors.secondary,
    label: 'Preview',
  );
}

final class _MemoryAppPageShellStorage implements AppPageShellStorage {
  _MemoryAppPageShellStorage({required this.showTabBar});

  bool showTabBar;

  @override
  Future<bool> loadShowTabBar() async {
    return showTabBar;
  }

  @override
  Future<void> saveShowTabBar(bool showTabBar) async {
    this.showTabBar = showTabBar;
  }
}
