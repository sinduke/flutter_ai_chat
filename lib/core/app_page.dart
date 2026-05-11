import 'package:flutter/cupertino.dart';
import 'package:flutter_ai_chat/common/design/app_colors.dart';
import 'package:flutter_ai_chat/common/preview/app_preview.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  bool _showTabBar = false;

  void _toggleAppShell() {
    setState(() {
      _showTabBar = !_showTabBar;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _toggleAppShell,
        child: ClipRect(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            layoutBuilder: (currentChild, previousChildren) {
              return Stack(
                fit: StackFit.expand,
                children: [...previousChildren, ?currentChild],
              );
            },
            transitionBuilder: (child, animation) {
              final isTabBarChild = child.key == const ValueKey('tabbar');
              final isIncoming = isTabBarChild == _showTabBar;
              final isMovingToTabBar = _showTabBar;
              final beginOffset = isIncoming
                  ? (isMovingToTabBar
                        ? const Offset(1, 0)
                        : const Offset(-1, 0))
                  : (isMovingToTabBar
                        ? const Offset(-1, 0)
                        : const Offset(1, 0));
              final position =
                  Tween<Offset>(begin: beginOffset, end: Offset.zero).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeInOutCubic,
                    ),
                  );

              return SlideTransition(position: position, child: child);
            },
            child: _showTabBar
                ? const _TabBarPlaceholder(key: ValueKey('tabbar'))
                : const _OnboardingPlaceholder(key: ValueKey('onboarding')),
          ),
        ),
      ),
    );
  }
}

class _TabBarPlaceholder extends StatelessWidget {
  const _TabBarPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const _FullScreenPanel(
      backgroundColor: AppColors.error,
      label: 'Tabbar',
    );
  }
}

class _OnboardingPlaceholder extends StatelessWidget {
  const _OnboardingPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const _FullScreenPanel(
      backgroundColor: AppColors.primary,
      label: 'Onboarding',
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
Widget appPagePreview() => const AppPage();

@AppPagePreview(group: 'AppPage', name: 'Onboarding')
Widget onboardingPlaceholderPreview() => const _OnboardingPlaceholder();

@AppPagePreview(group: 'AppPage', name: 'Tabbar')
Widget tabBarPlaceholderPreview() => const _TabBarPlaceholder();

@AppPagePreview(group: 'AppPage', name: 'Panel')
Widget fullScreenPanelPreview() {
  return const _FullScreenPanel(
    backgroundColor: AppColors.secondary,
    label: 'Preview',
  );
}
