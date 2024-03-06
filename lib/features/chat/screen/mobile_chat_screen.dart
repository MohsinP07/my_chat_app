import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mychat_app/colors.dart';
import 'package:mychat_app/common/widgets/loader.dart';
import 'package:mychat_app/features/auth/controller/auth_controller.dart';
import 'package:mychat_app/features/chat/widgets/bottom_chat_field.dart';
import 'package:mychat_app/models/user_model.dart';
import 'package:mychat_app/features/chat/widgets/chat_list.dart';

class MobileChatScreen extends ConsumerWidget {
  static const String routeName = "/mobile-chat-screen";
  final String name;
  final String uid;
  final bool isGroupChat;
  const MobileChatScreen(
      {Key? key,
      required this.name,
      required this.uid,
      required this.isGroupChat})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: isGroupChat
            ? Text(
                name,
              )
            : StreamBuilder<UserModel>(
                stream: ref.read(authControllerProvider).getUserById(uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Loader();
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                      ),
                      Text(
                        snapshot.data!.isOnline ? "online" : "offfline",
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.normal),
                      )
                    ],
                  );
                }),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatList(recieverUserId: uid, isGroupChat: isGroupChat),
          ),
          BottomChatField(recieverUserId: uid, isGroupChat: isGroupChat),
        ],
      ),
    );
  }
}
