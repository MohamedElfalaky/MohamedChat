// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohamed_chat/View/Screens/Chat/Components/chat_list.dart';

import '../../../App/constants.dart';
import '../../../Data/Models/msg_content_model.dart';
import '../../../Style/Icons.dart';
import '../../../helpers/globals.dart';
import 'chat_controller.dart';

class ChatScreen extends StatefulWidget {
  final String docId;
  final String toUid;
  final String toName;
  final String toAvatar;
  ChatScreen(
      {super.key,
      required this.docId,
      required this.toUid,
      required this.toName,
      required this.toAvatar});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    // TODO: implement initState

    initMsgListenet();
    super.initState();
  }

  void dispose() {
    _textController.dispose();
    listener!.cancel();
    super.dispose();
  }

  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  StreamSubscription? listener;
  Stream<QuerySnapshot<MsgContent>>? myStream;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
              // toolbarHeight: 90,
              backgroundColor: Colors.green,
              centerTitle: false,
              leadingWidth: 70,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 50,
                        width: 50,
                        // decoration: BoxDecoration(shape: BoxShape.circle),
                        child: CachedNetworkImage(
                          imageUrl: widget.toAvatar,
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              height: 50,
                              width: 50,
                              margin: null,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover)),
                            );
                          },
                          errorWidget: (context, url, error) => Image.network(
                              "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.toName),
                          Text(
                            // "12/2/2022 - 10:46 ص",
                            "unknown locaton..",
                            style: Constants.subtitleFont
                                .copyWith(fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SvgPicture.asset(
                    logoColor,
                    // color: Constants.primaryAppColor,
                    height: 50,
                  )
                ],
              ),
              leading: const BackButton()),
          body: SizedBox(
              child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
            child: Column(
              children: [
                Expanded(
                    child: StreamBuilder(
                        stream: myStream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.none) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasData) {
                            return ChatList();
                          } else {
                            return Text("error");
                          }
                        })),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          focusNode: _focusNode,
                          decoration: Constants.setTextInputDecoration(
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(attachFiles),
                                SizedBox(
                                  width: 8,
                                ),
                                SvgPicture.asset(micee),
                                SizedBox(
                                  width: 8,
                                )
                              ],
                            ),
                            hintText: "آكتب رسالتك...",
                          ).copyWith(
                            hintStyle: Constants.subtitleRegularFontHint
                                .copyWith(color: Color(0XFF5C5E6B)),
                            enabledBorder: const OutlineInputBorder(
                              gapPadding: 0,
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              // gapPadding: 0,
                              borderSide:
                                  BorderSide(color: Colors.green, width: 2),

                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                            filled: true,
                            fillColor: const Color(0xffF5F4F5),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => sendMessage(),
                        child: Container(
                            margin: EdgeInsetsDirectional.only(start: 8),
                            padding: EdgeInsets.all(10),
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0XFF273043)),
                            child: SvgPicture.asset(
                              sendChat,
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ))),
    );
  }

  void sendMessage() async {
    String sentContent = _textController.text;

    final content = MsgContent(
        uid: ChatController.userToken,
        content: sentContent,
        type: "text",
        addtime: Timestamp.now());

    await db
        .collection("message")
        .doc(widget.docId)
        .collection("msglist")
        .withConverter(
          fromFirestore: MsgContent.fromFirestore,
          toFirestore: (MsgContent msgContent, options) =>
              msgContent.toFirestore(),
        )
        .add(content)
        .then((value) {
      print(" Document with id :${value.id} is added");
      _textController.clear();
      FocusManager.instance.primaryFocus?.unfocus();
    });

    await db
        .collection("message")
        .doc(widget.docId)
        .update({"last_msg": sentContent, "last_msg": Timestamp.now()});
  }

  initMsgListenet() async {
    var messages = await db
        .collection("message")
        .doc(widget.docId)
        .collection("msglist")
        .withConverter(
          fromFirestore: MsgContent.fromFirestore,
          toFirestore: (MsgContent msgContent, options) =>
              msgContent.toFirestore(),
        )
        .orderBy("addtime", descending: false);
    msgContentList.clear();

    // msgContentList.insert(0, messages.snapshots())
    myStream = messages.snapshots();

    listener = messages.snapshots().listen((event) {
      for (var changes in event.docChanges) {
        switch (changes.type) {
          case DocumentChangeType.added:
            if (changes.doc.data() != null) {
              msgContentList.insert(0, changes.doc.data()!);
            }

            break;
          case DocumentChangeType.modified:
            break;
          case DocumentChangeType.removed:
            break;
        }
      }
    }, onError: (e) => print("Mohamed Error:: $e"));

    setState(() {});
  }
}
