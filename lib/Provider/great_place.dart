import 'package:flutter/cupertino.dart';
import 'package:placeapp/models/place.dart';
import "dart:io";
import '../helpers/db_helpers.dart';

class GreatPlace extends ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String pickedtitle, File pickedimage) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: pickedtitle,
        image: pickedimage,
        location: null);
    _items.add(newPlace);
    notifyListeners();

    DBhelper.insert('place', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path
    });
  }

  Future<void> getandSetPlaces() async {
    final datalist = await DBhelper.getData('place');
    _items = datalist
        .map((item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: null))
        .toList();
    notifyListeners();
  }
}
