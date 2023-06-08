import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:mohamed_chat/View/Screens/Chat/chat_screen.dart';
import 'package:mohamed_chat/helpers/CacheHelper.dart';
import 'package:mohamed_chat/helpers/globals.dart';
import 'package:mohamed_chat/helpers/myApplication.dart';

import '../../../Data/Models/messages_model.dart';
import '../../../Data/Models/user_data_model.dart';

class ContactController {
  // static List<UserData> contactList = [];

  static Future<List<UserData>> asyncLoadAllData() async {
    var usersBase = await db
        .collection("users")
        .where("id", isNotEqualTo: CacheHelper.getFromShared("id"))
        .withConverter(
          fromFirestore: UserData.fromFirestore,
          toFirestore: (value, options) => value.toFirestore(),
        )
        .get();
    List<UserData> contactList = [];
    for (var docc in usersBase.docs) {
      contactList.add(docc.data());
      print(docc.data().name);
    }

    return contactList;
  }

  // مهمة جداااااا

  static goChat(UserData to_userData, BuildContext context) async {
    // if we have previouse masseges:
    var from_messages = await db
        .collection("message")
        .withConverter(
          fromFirestore: Msg.fromFirestore,
          toFirestore: (Msg msg, options) => msg.toFirestore(),
        )
        .where("from_uid", isEqualTo: CacheHelper.getFromShared("id"))
        .where("to_uid", isEqualTo: to_userData.id)
        .get();

    var to_messages = await db
        .collection("message")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where("from_uid", isEqualTo: to_userData.id)
        .where("to_uid", isEqualTo: CacheHelper.getFromShared("id"))
        .get();

    // if we dont have previous messages:
    if (from_messages.docs.isEmpty && to_messages.docs.isEmpty) {
      var fstMsg = Msg(
        from_uid: CacheHelper.getFromShared("id"),
        to_uid: to_userData.id,
        from_name: CacheHelper.getFromShared("name"),
        to_name: to_userData.name,
        from_avatar: CacheHelper.getFromShared("photo"),
        to_avatar: to_userData.photoUrl,
        last_msg: "",
        last_time: Timestamp.now(),
        msg_num: 0,
      );

      db
          .collection("message")
          .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore(),
          )
          .add(fstMsg)
          .then((value) {
        myApplication.navigateTo(
            ChatScreen(
                docId: value.id,
                toUid: to_userData.id ?? "",
                toName: to_userData.name ?? "",
                toAvatar: to_userData.photoUrl ?? ""),
            context);
      });
    } else {
      if (from_messages.docs.isNotEmpty) {
        // ignore: use_build_context_synchronously
        myApplication.navigateTo(
            ChatScreen(
                docId: from_messages.docs.first.id,
                toUid: to_userData.id ?? "",
                toName: to_userData.name ?? "",
                toAvatar: to_userData.photoUrl ?? ""),
            context);
      }
      if (to_messages.docs.isNotEmpty) {
        // ignore: use_build_context_synchronously
        myApplication.navigateTo(
            ChatScreen(
                docId: to_messages.docs.first.id,
                toUid: to_userData.id ?? "",
                toName: to_userData.name ?? "",
                toAvatar: to_userData.photoUrl ?? ""),
            context);
      }
    }
  }
}
