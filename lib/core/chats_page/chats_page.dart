import 'package:flutter/cupertino.dart';
import 'package:flutter_ai_chat/common/preview/app_preview.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Chats')),
      child: Center(child: Text(key: ValueKey('chats-page-title'), 'Chats')),
    );
  }
}

@AppPagePreview(group: 'TabbarPage', name: 'ChatsPage')
Widget chatsPagePreview() => const ChatsPage();
