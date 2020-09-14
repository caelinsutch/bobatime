import 'package:boba_time/models/boba-shop.model.dart';
import 'package:boba_time/models/models.dart';

class UserModel {
  String uid;
  String email;
  String name;
  String photoUrl;
  String bio;
  int postCount;
  int followerCount;
  int followedCount;
  List<String> nameForSearch;
  List<String> posts;
  List<BobaShopModel> favoriteBobaShops;
  List<NotificationModel> notifications;

  UserModel(
      {this.uid,
      this.email,
      this.name,
      this.photoUrl,
      this.bio,
      this.postCount,
      this.followerCount,
      this.followedCount,
      this.nameForSearch,
      this.posts,
      this.favoriteBobaShops,
      this.notifications});

  factory UserModel.fromMap(Map data) {
    return UserModel(
        uid: data['uid'],
        email: data['email'] ?? '',
        name: data['name'] ?? '',
        photoUrl: data['photoUrl'] ?? '',
        bio: data['bio'] ?? '',
        postCount: data['postCount'] ?? 0,
        followerCount: data['followerCount'] ?? 0,
        followedCount: data['followedCount'] ?? 0,
        nameForSearch: data['dataForSearch'] ?? [],
        posts: data['posts'] ?? [],
        favoriteBobaShops: data['favoriteBobaShops'] != null
            ? data['favoriteBobaShops']
                .map((shop) => BobaShopModel.fromMap(shop))
            : [],
        notifications: data['notifications'] != null
            ? data['notifications']
                .map((notification) => NotificationModel.fromMap(notification))
            : []);
  }

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "email": email,
        "name": name,
        "photoUrl": photoUrl,
        "bio": bio,
        "postCount": postCount,
        "followerCount": followerCount,
        "followedCount": followedCount,
        "nameForSearch": nameForSearch,
        "posts": posts,
        "favoriteBobaShops": favoriteBobaShops.map((e) => e.toMap()),
        "notifications": notifications.map((e) => e.toMap())
      };
}
