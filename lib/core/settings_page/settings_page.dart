import 'package:flutter/cupertino.dart';
import 'package:flutter_ai_chat/common/design/app_colors.dart';
import 'package:flutter_ai_chat/common/design/app_spacing.dart';
import 'package:flutter_ai_chat/common/preview/app_preview.dart';
import 'package:flutter_ai_chat/common/widgets/app_primary_action_button.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, this.onLogout});

  final VoidCallback? onLogout;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isLoggingOut = false;

  Future<void> _logout() async {
    if (_isLoggingOut) {
      return;
    }

    setState(() {
      _isLoggingOut = true;
    });

    await Future<void>.delayed(const Duration(seconds: 1));

    if (!mounted) {
      return;
    }

    widget.onLogout?.call();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Settings')),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              const Expanded(
                child: Center(
                  child: Text('Settings', key: ValueKey('settings-page-title')),
                ),
              ),
              AppPrimaryActionButton(
                key: const ValueKey('settings-page-logout-button'),
                label: _isLoggingOut ? 'Logging out...' : 'Logout',
                backgroundColor: AppColors.error,
                onPressed: _isLoggingOut ? null : _logout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

@AppPagePreview(group: 'Settings', name: 'SettingsPage')
Widget settingsPagePreview() => const SettingsPage();
