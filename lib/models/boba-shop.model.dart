class Coordinates {
  double latitude;
  double longitude;

  Coordinates({this.latitude, this.longitude});

  factory Coordinates.fromMap(Map data) {
    return Coordinates(
        latitude: data['latitude'], longitude: data['longitude']);
  }

  Map<String, dynamic> toMap() => {
        'latitude': latitude,
        'longitude': longitude,
      };
}

class BobaShopModel {
  String id;
  String name;
  String imageUrl;
  double rating;
  Coordinates coordinates;
  bool isSaved;

  BobaShopModel(
      {this.id, this.name, this.imageUrl, this.rating, this.coordinates}) : this.isSaved = false;

  factory BobaShopModel.fromMap(Map data) {
    return BobaShopModel(
        id: data['id'],
        name: data['name'],
        imageUrl: data['image_url'],
        rating: data['rating'],
        coordinates: Coordinates.fromMap(data['coordinates']));
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "imageUrl": imageUrl,
        "rating": rating,
        "coordinates": coordinates.toMap()
      };
}
