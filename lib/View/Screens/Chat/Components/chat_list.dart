import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mohamed_chat/View/Screens/Chat/Components/left_chat_Item.dart';
import 'package:mohamed_chat/View/Screens/Chat/Components/right_chat_Item.dart';
import 'package:mohamed_chat/View/Screens/Chat/chat_controller.dart';

import '../../../../Data/Models/msg_content_model.dart';
import '../../../../helpers/globals.dart';

class ChatList extends StatefulWidget {
  ChatList({
    super.key,
  });

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final ScrollController _msgScrolling = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Constants.primaryAppColor,
      padding: EdgeInsets.only(bottom: 10),
      child: CustomScrollView(
        reverse: true,
        controller: _msgScrolling,
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(),
            sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              var item = msgContentList[index];
              if (ChatController.userToken == item.uid) {
                return RightChatItem(item: item);
              }

              return LeftChatItem(item: item);
            }, childCount: msgContentList.length)),
          )
        ],
      ),
    );
  }
}
