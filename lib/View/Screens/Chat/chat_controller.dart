import 'package:mohamed_chat/helpers/CacheHelper.dart';

class ChatController {
  // static List<MsgContent> msgContentList = [];
  // static final TextEditingController chatScreenTextController = TextEditingController();
  // static final FocusNode chatScreenfocusNode = FocusNode();
  // static final ScrollController chatScreenmsgScrolling = ScrollController();
  static final String userToken = CacheHelper.getFromShared("id");
}
