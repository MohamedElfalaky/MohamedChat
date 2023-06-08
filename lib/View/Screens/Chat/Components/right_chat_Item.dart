import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mohamed_chat/Data/Models/msg_content_model.dart';

class RightChatItem extends StatelessWidget {
  final MsgContent item;
  const RightChatItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(8),
          // constraints: BoxConstraints(mi),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 1, 159, 30).withOpacity(0.2),
              borderRadius: BorderRadius.circular(20)),
          child: item.type == "text"
              ? ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.6,
                  ),
                  child: Text(
                    item.content ?? "",
                    maxLines: 3,
                    // style: Constants.subtitleFont,
                  ),
                )
              : ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 90,
                  ),
                  child: GestureDetector(
                    onTap: () {},
                    child: CachedNetworkImage(imageUrl: item.content ?? ""),
                  ),
                ),
        ),
      ],
    );
  }
}
