import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:mohamed_chat/helpers/CacheHelper.dart';
import 'package:mohamed_chat/helpers/myApplication.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../Data/Models/login_model.dart';
import '../../../Data/Models/user_data_model.dart';
import '../../../helpers/globals.dart';
import '../MainScreen/super_main_screen.dart';

class WelcomeController {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ]);

  static Future<void> handleSignIn(BuildContext context) async {
    try {
      var user = await _googleSignIn.signIn();
      if (user != null) {
        final _gAuthentcation = await user.authentication;
        final _credential = GoogleAuthProvider.credential(
            idToken: _gAuthentcation.idToken,
            accessToken: _gAuthentcation.accessToken);

        await FirebaseAuth.instance
            .signInWithCredential(_credential)
            .then((value) => CacheHelper.saveBoolToShared("isLogedin", true));

        String displayName = user.displayName ?? user.email;
        String email = user.email;
        String id = user.id;
        String photo = user.photoUrl ?? "";

        print([displayName, email, id, photo]);

        // save to device memory
        CacheHelper.saveToShared("name", displayName);
        CacheHelper.saveToShared("mail", email);
        CacheHelper.saveToShared("id", id);
        CacheHelper.saveToShared("photo", photo);

        //assign model
        LoginModel loginModel = LoginModel();
        loginModel.accessToken = id;
        loginModel.displayName = displayName;
        loginModel.email = email;
        loginModel.photoUrl = photo;

        // deal with database
        var userBase = await db
            .collection("users")
            .withConverter(
              fromFirestore: UserData.fromFirestore,
              toFirestore: (UserData userData, options) =>
                  userData.toFirestore(),
            )
            .where("id", isEqualTo: id)
            .get();
        if (userBase.docs.isEmpty) {
          final data = UserData(
              id: id,
              name: displayName,
              email: email,
              photoUrl: photo,
              location: "",
              fcmToken: "",
              addTime: Timestamp.now());

          await db
              .collection("users")
              .withConverter(
                fromFirestore: UserData.fromFirestore,
                toFirestore: (UserData userData, options) =>
                    userData.toFirestore(),
              )
              .add(data);
          print("aaaaaaaadeddddd");
        }

        myApplication.showToast(text: "Log in success", color: Colors.green);
        myApplication.navigateTo(SuperMainScreen(), context);
      }
    } catch (e) {
      myApplication.showToast(text: "Log in Error", color: Colors.red);
      print(e);
    }
  }

  static void onReady() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print("user Logged out");
      } else {
        print("User logged in");
      }
    });
  }
}
