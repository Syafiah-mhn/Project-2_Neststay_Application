import 'package:flutter/material.dart';
import 'package:testpro2/booking/viewhotelscreen.dart';
import 'package:testpro2/nav_bar/FavoriteManager.dart';
//import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritesManager()),
        // Add other providers if needed
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FavoritePage(),
      // Add other configurations for your app
    );
  }
}

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var favoriteHotels = context.watch<FavoritesManager>().favoriteHotels;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [        
          Expanded(
            child: ListView.builder(
              itemCount: favoriteHotels.length,
              itemBuilder: (context, index) {
                return HotelCard(hotel: favoriteHotels[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

