class Coordinates {
  double latitude;
  double longitude;

  Coordinates({this.latitude, this.longitude});

  factory Coordinates.fromMap(Map data) {
    return Coordinates(
        latitude: data['latitude'], longitude: data['longitude']);
  }
}

class BobaShopModel {
  String id;
  String name;
  String imageUrl;
  bool isClosed;
  String url;
  double rating;
  Coordinates coordinates;
  String displayAddress;

  BobaShopModel(
      {this.id,
      this.name,
      this.imageUrl,
      this.isClosed,
      this.url,
      this.rating,
      this.coordinates,
      this.displayAddress});

  factory BobaShopModel.fromMap(Map data) {
    return BobaShopModel(
        id: data['id'],
        name: data['name'],
        imageUrl: data['image_url'],
        isClosed: data['is_closed'],
        url: data['url'],
        rating: data['rating'],
        coordinates: Coordinates.fromMap(data['coordinates']),
        displayAddress: data['display_address']);
  }
}
