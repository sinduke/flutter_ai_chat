import 'package:flutter/cupertino.dart';
import 'package:flutter_ai_chat/common/design/app_colors.dart';
import 'package:flutter_ai_chat/common/design/app_radii.dart';

class AppPrimaryActionButton extends StatelessWidget {
  const AppPrimaryActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor = AppColors.error,
  });

  final String label;
  final VoidCallback? onPressed;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: CupertinoButton(
        color: backgroundColor,
        disabledColor: backgroundColor.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(AppRadii.lg),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(color: CupertinoColors.white),
        ),
      ),
    );
  }
}
