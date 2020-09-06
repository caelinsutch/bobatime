import 'package:boba_time/models/boba-shop.model.dart';

class PostModel {
  String posterId;
  String posterPhotoUrl;
  String posterName;
  BobaShopModel bobaShop;
  String photoUrl;
  String description;
  String createdAt;

  PostModel(
      {this.posterId,
      this.posterPhotoUrl,
      this.posterName,
      this.bobaShop,
      this.photoUrl,
      this.description,
      this.createdAt});

  factory PostModel.fromMap(Map data) {
    return PostModel(
      posterId: data['posterId'] ?? '',
      posterPhotoUrl: data['posterPhotoUrl'] ?? '',
      posterName: data['posterName'] ?? '',
      bobaShop: BobaShopModel.fromMap(data['bobaShop']) ?? BobaShopModel(),
      photoUrl: data['photoUrl'] ?? '',
      description: data['description'] ?? '',
      createdAt: data['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
    'posterId': posterId,
    'posterPhotoUrl': posterPhotoUrl,
    'posterName': posterName,
    'bobaShop': bobaShop.toMap(),
    'photoUrl': photoUrl,
    'description': description,
    createdAt: createdAt
  };
}
