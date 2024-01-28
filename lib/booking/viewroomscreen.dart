import 'package:flutter/material.dart';
import 'package:testpro2/booking/detailsroom.dart';
import 'package:testpro2/model/room.dart' as RoomModel; // Use 'as' to create an alias
import 'package:testpro2/data/dummyroom.dart';

class ViewRoomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Rooms'),
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
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          return RoomCard(room: rooms[index]);
        },
      ),
    );
  }
}

class RoomCard extends StatefulWidget {
  final RoomModel.Room room; // Use the alias to disambiguate the class name

  const RoomCard({Key? key, required this.room}) : super(key: key);

  @override
  _RoomCardState createState() => _RoomCardState();
}

class _RoomCardState extends State<RoomCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Column(
        children: [
          ListTile(
            title: Text(widget.room.name),
            subtitle: Text('Accommodates ${widget.room.noOfPeople} people'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
                    MaterialPageRoute(builder: (context) => DetailsRoom(room: widget.room)),
                  );
                },
                child: Text('Select Room'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
