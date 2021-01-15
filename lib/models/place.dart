import 'dart:io';

class PlaceLocation {
  final double longitude;
  final double latitude;
  final String address;

  PlaceLocation({this.longitude, this.latitude, this.address});
}

class Place {
  final String id;
  final String title;
  final File image;
  final PlaceLocation location;

  Place({this.id, this.title, this.image, this.location});
}
