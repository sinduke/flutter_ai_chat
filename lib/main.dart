import 'package:flutter/cupertino.dart';
import 'package:flutter_ai_chat/common/design/app_colors.dart';
import 'package:flutter_ai_chat/core/app_page/app_page.dart';
import 'package:flutter_ai_chat/core/app_page/app_page_shell_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.appPageShellStorage});

  final AppPageShellStorage? appPageShellStorage;

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter AI Chat',
      debugShowCheckedModeBanner: false,
      theme: const CupertinoThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
      ),
      home: AppPage(shellStorage: appPageShellStorage),
    );
  }
}
