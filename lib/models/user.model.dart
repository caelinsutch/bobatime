class UserModel {
  String uid;
  String email;
  String name;
  String photoUrl;
  String bio;

  UserModel({this.uid, this.email, this.name, this.photoUrl, this.bio});

  factory UserModel.fromMap(Map data) {
    return UserModel(
        uid: data['uid'],
        email: data['email'] ?? '',
        name: data['name'] ?? '',
        photoUrl: data['photoUrl'] ?? '',
        bio: data['bio'] ?? '');
  }

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "email": email,
        "name": name,
        "photoUrl": photoUrl,
        "bio": bio
      };
}
