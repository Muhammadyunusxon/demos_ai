class UserModel {
  String? name;
  String? username;
  String? password;
  String? avatar;
  String? bio;
  String? birth;
  String? email;
  String? phone;
  String? fcmToken;
  String? docId;
  int dailyLimit;
  int extraLimit;
  String lastTime;
  String joinTime;

  UserModel({
    required this.name,
    required this.username,
    required this.password,
    this.avatar,
    this.bio,
    required this.birth,
    required this.email,
    required this.phone,
    required this.fcmToken,
    this.docId,
    required this.extraLimit,
    required this.lastTime,
    required this.dailyLimit,
    required this.joinTime,
  });

  factory UserModel.fromJson({Map? data, required String docId}) {
    return UserModel(
        name: data?["name"],
        username: data?["username"],
        password: data?["password"],
        avatar: data?["avatar"],
        bio: data?["bio"],
        birth: data?["birth"],
        email: data?["email"],
        phone: data?["phone"],
        fcmToken: data?["fcmToken"],
        docId: docId,
        dailyLimit: data?["dailyLimit"] ?? 0,
        extraLimit: data?["extraLimit"] ?? 0,
        lastTime: data?["lastTime"],
        joinTime: data?["joinTime"]);
  }

  toJson() {
    return {
      "name": name,
      "username": username,
      "password": password,
      "avatar": avatar,
      "bio": bio,
      "birth": birth,
      "email": email,
      "phone": phone,
      "fcmToken": fcmToken,
      "dailyLimit": dailyLimit,
      "lastTime": lastTime,
      "extraLimit": extraLimit,
      "joinTime": joinTime
    };
  }
}
