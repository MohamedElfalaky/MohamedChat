class LoginModel {
  String? accessToken;
  String? displayName;
  String? email;
  String? photoUrl;

  LoginModel({this.accessToken, this.displayName, this.email, this.photoUrl});

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
      accessToken: json["access_token"],
      displayName: json["display_name"],
      email: json["email"],
      photoUrl: json["photoUrl"]);

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "display_name": displayName,
        "email": email,
        "photoUrl": photoUrl
      };
}
