import 'package:flutter/cupertino.dart';
import 'package:flutter_ai_chat/common/design/app_colors.dart';
import 'package:flutter_ai_chat/common/design/app_spacing.dart';
import 'package:flutter_ai_chat/common/preview/app_preview.dart';
import 'package:flutter_ai_chat/common/widgets/app_primary_action_button.dart';

class OnboardCompletedPage extends StatelessWidget {
  const OnboardCompletedPage({super.key, this.onExit});

  final VoidCallback? onExit;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Onboarding Completed'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              const Expanded(
                child: Center(
                  child: Text(
                    'Onboarding Completed',
                    key: ValueKey('onboard-completed-page-title'),
                  ),
                ),
              ),
              AppPrimaryActionButton(
                key: const ValueKey('onboard-completed-page-completed-button'),
                label: 'Completed',
                backgroundColor: AppColors.error,
                onPressed: () {
                  onExit?.call();
                  Navigator.of(context).maybePop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

@AppPagePreview(group: 'Onboarding', name: 'OnboardCompletedPage')
Widget onboardCompletedPagePreview() => const OnboardCompletedPage();
