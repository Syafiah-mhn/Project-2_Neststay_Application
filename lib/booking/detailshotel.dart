import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testpro2/model/hotel.dart';
import 'package:testpro2/model/room.dart';
import 'package:testpro2/nav_bar/FavoriteManager.dart';
//import 'package:testpro2/booking/detailsroom.dart';
import 'package:testpro2/booking/viewroomscreen.dart'; // Import ViewRoomPage

class DetailsHotel extends StatefulWidget {
  final Hotel hotel;

  const DetailsHotel({
    required this.hotel,
    Key? key,
  }) : super(key: key);

  @override
  State<DetailsHotel> createState() => _DetailsHotelState();
}

class _DetailsHotelState extends State<DetailsHotel> {

  void _toggleFavorite(Hotel hotel) {
    var favoritesManager = context.read<FavoritesManager>();
    if (favoritesManager.favoriteHotels.contains(hotel)) {
      favoritesManager.removeFromFavorites(hotel);
    } else {
      favoritesManager.addToFavorites(hotel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
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
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: const Text(
                "",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          Container(
            foregroundDecoration: const BoxDecoration(
              color: Colors.black26,
            ),
            height: 400,
            child: Image.asset(
              widget.hotel.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 250,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "${widget.hotel.name}\n${widget.hotel.location}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    const SizedBox(width: 16.0),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text(
                        '${widget.hotel.rating}/5 ratings',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      color: Colors.red, // Change to your desired color
                      icon: Icon(
                        context.watch<FavoritesManager>().favoriteHotels.contains(widget.hotel)
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                      onPressed: () {
                        _toggleFavorite(widget.hotel);
                      },
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(32.0),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.star,
                                      color: Colors.purple,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.purple,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.purple,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.purple,
                                    ),
                                    Icon(
                                      Icons.star_border,
                                      color: Colors.purple,
                                    ),
                                  ],
                                ),
                                Text.rich(
                                  TextSpan(children: [
                                    WidgetSpan(
                                      child: Icon(
                                        Icons.location_on,
                                        size: 16.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    TextSpan(text: "${widget.hotel.location}"),
                                  ]),
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                "RM ${widget.hotel.price.toStringAsFixed(2)}",
                                style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                              Text(
                                "/per night",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            primary: Colors.purple,
                            onPrimary: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 32.0,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewRoomPage(), // Change to ViewRoomPage
                              ),
                            );
                          },
                          child: const Text(
                            "Select Room",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        "Description".toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        widget.hotel.description,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
