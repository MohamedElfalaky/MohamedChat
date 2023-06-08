import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String? id;
  String? name;
  String? email;
  String? photoUrl;
  String? location;
  String? fcmToken;
  Timestamp? addTime;

  UserData(
      {this.id,
      this.name,
      this.email,
      this.photoUrl,
      this.location,
      this.fcmToken,
      this.addTime});

  factory UserData.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return UserData(
      id: data?["id"],
      name: data?["name"],
      email: data?["email"],
      photoUrl: data?["photoUrl"],
      location: data?["location"],
      fcmToken: data?["fcmtoken"],
      addTime: data?["addtime"],
    );
  }

  Map<String, dynamic> toFirestore() => {
        if (id != null) "id": id,
        if (name != null) "name": name,
        if (email != null) "email": email,
        if (photoUrl != null) "photoUrl": photoUrl,
        if (location != null) "location": location,
        if (fcmToken != null) "fcmtoken": fcmToken,
        if (addTime != null) "addtime": addTime,
      };
}
