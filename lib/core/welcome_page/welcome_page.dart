import 'package:flutter/cupertino.dart';
import 'package:flutter_ai_chat/common/design/app_colors.dart';
import 'package:flutter_ai_chat/common/design/app_spacing.dart';
import 'package:flutter_ai_chat/common/preview/app_preview.dart';
import 'package:flutter_ai_chat/common/widgets/app_primary_action_button.dart';
import 'package:flutter_ai_chat/core/onboarding/completed_page/onboard_completed_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key, this.onOnboardingCompleted});

  final VoidCallback? onOnboardingCompleted;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    'Welcome!',
                    key: const ValueKey('welcome-page-title'),
                    style: CupertinoTheme.of(context).textTheme.textStyle,
                  ),
                ),
              ),
              AppPrimaryActionButton(
                key: const ValueKey('welcome-page-get-started-button'),
                label: 'Get Started',
                backgroundColor: AppColors.error,
                onPressed: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute<void>(
                      builder: (context) =>
                          OnboardCompletedPage(onExit: onOnboardingCompleted),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

@AppPagePreview(group: 'Onboarding', name: 'WelcomePage')
Widget welcomePagePreview() => const WelcomePage();
