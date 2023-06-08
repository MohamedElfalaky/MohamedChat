import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mohamed_chat/View/Screens/Chat/chat_screen.dart';

import '../Contact/contact_screen.dart';
import '../Profile/profile_screen.dart';

class SuperMainScreen extends StatefulWidget {
  SuperMainScreen({super.key});

  @override
  State<SuperMainScreen> createState() => _SuperMainScreenState();
}

class _SuperMainScreenState extends State<SuperMainScreen> {
  int currentIndex = 0;

  final screens = <Widget>[ContactScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(index: currentIndex, children: screens),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 20,

          // fixedColor: Colors.white,
          unselectedItemColor: Color.fromARGB(179, 0, 0, 0),
          selectedItemColor: Colors.green,
          // showUnselectedLabels: false,
          type: BottomNavigationBarType.shifting,
          backgroundColor: Colors.white,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              // if (isVisitor && (index == 2 || index == 3)) {
              //   MyApplication().showToastView(
              //       message: '${getTranslated(context, 'PleaseLoginfirst')}');
              // } else {
              currentIndex = index;
              // }
            });
          },
          items: [
            // BottomNavigationBarItem(
            //     activeIcon: Container(
            //       padding: EdgeInsets.all(4),
            //       // height: ,
            //       child: Icon(Icons.message),
            //     ),
            //     icon: Icon(Icons.message),
            //     label: "Chat"),
            BottomNavigationBarItem(
                activeIcon: Container(
                  padding: EdgeInsets.all(4),
                  child: Icon(Icons.contact_phone),
                ),
                icon: Icon(Icons.contact_phone),
                label: "Contact"),
            BottomNavigationBarItem(
                activeIcon: Container(
                  padding: EdgeInsets.all(4),
                  child: Icon(Icons.person_outline),
                ),
                icon: Icon(Icons.person_outline),
                label: "profile"),
          ],
        ));
  }
}
