import 'package:flutter/cupertino.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_ai_chat/common/design/app_colors.dart';

abstract final class AppPreviewSizes {
  static const Size phone = Size(390, 844);
  static const Size component = Size.fromWidth(390);
}

Widget appPreviewWrapper(Widget child) {
  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    theme: const CupertinoThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
    ),
    home: child,
  );
}

base class AppPagePreview extends Preview {
  const AppPagePreview({
    super.group = 'Page',
    super.name,
    super.size = AppPreviewSizes.phone,
  }) : super(wrapper: appPreviewWrapper);
}

base class AppComponentPreview extends Preview {
  const AppComponentPreview({
    super.group = 'Component',
    super.name,
    super.size = AppPreviewSizes.component,
  }) : super(wrapper: appPreviewWrapper);
}
