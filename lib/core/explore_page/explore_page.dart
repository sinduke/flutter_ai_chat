import 'package:flutter/cupertino.dart';
import 'package:flutter_ai_chat/common/preview/app_preview.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Explore')),
      child: Center(
        child: Text(key: ValueKey('explore-page-title'), 'Explore'),
      ),
    );
  }
}

@AppPagePreview(group: 'TabbarPage', name: 'ExplorePage')
Widget explorePagePreview() => const ExplorePage();
