import 'package:flutter/material.dart';
import 'package:testpro2/booking/detailshotel.dart';
import 'package:testpro2/nav_bar/FavoriteManager.dart';
import 'package:provider/provider.dart';
import 'package:testpro2/model/hotel.dart' as HotelModel; // Use 'as' to create an alias
import 'package:testpro2/data/dummyhotel.dart';
//import 'package:testpro2/nav_bar/HomePage.dart';

class ViewHotelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Use the watch method inside the build method
    final favoritesManager = context.watch<FavoritesManager>();

    return Scaffold(
      appBar: AppBar(
        title: Text('List of Hotel'),
        backgroundColor: Colors.purple,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView.builder(
        itemCount: hotels.length,
        itemBuilder: (context, index) {
          return HotelCard(hotel: hotels[index]);
        },
      ),
    );
  }
}

class HotelCard extends StatefulWidget {
  final HotelModel.Hotel hotel; // Use the alias to disambiguate the class name

  const HotelCard({Key? key, required this.hotel}) : super(key: key);

  @override
  _HotelCardState createState() => _HotelCardState();
}

class _HotelCardState extends State<HotelCard> {
  @override
  Widget build(BuildContext context) {
    var isFavorite = context.watch<FavoritesManager>().favoriteHotels.contains(widget.hotel);

    return Card(
      margin: EdgeInsets.all(8),
      child: Column(
        children: [
          ListTile(
            leading: Image.asset(
              widget.hotel.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            title: Text(widget.hotel.name),
            subtitle: Text('${widget.hotel.location}'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () {
                  var favoritesManager = context.read<FavoritesManager>();
                  if (isFavorite) {
                    favoritesManager.removeFromFavorites(widget.hotel);
                  } else {
                    favoritesManager.addToFavorites(widget.hotel);
                  }
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  primary: Colors.purple,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailsHotel(hotel: widget.hotel)),
                  );
                },
                child: Text('View Hotel'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
