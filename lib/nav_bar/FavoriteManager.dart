import 'package:flutter/material.dart';
//import 'package:testpro2/booking/viewhotelscreen.dart';
import 'package:testpro2/model/hotel.dart';

class FavoritesManager extends ChangeNotifier {
  List<Hotel> _favoriteHotels = [];

  List<Hotel> get favoriteHotels => _favoriteHotels;

  void addToFavorites(Hotel hotel) {
    _favoriteHotels.add(hotel);
    notifyListeners();
  }

  void removeFromFavorites(Hotel hotel) {
    _favoriteHotels.removeWhere((element) => element.id == hotel.id);
    notifyListeners();
  }
}
