import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../Data/Models/msg_content_model.dart';

// my firestore database
final db = FirebaseFirestore.instance;
List<MsgContent> msgContentList = [];
