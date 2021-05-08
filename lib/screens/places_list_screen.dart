import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';
import '../providers/great_place.dart';
import './place_detail_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
        },
        label: Text('Add Location'),
        icon: Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                child: Center(
                  child: const Text('Got no places yet, start adding some!'),
                ),
                builder: (ctx, greatPlaces, ch) => greatPlaces.items.length <= 0
                    ? ch
                    : ListView.builder(
                        itemCount: greatPlaces.items.length,
                        itemBuilder: (ctx, i) => Card(
                          color: Colors.indigo[50],
                          elevation: 9,
                          shadowColor: Theme.of(context).primaryColor,
                          margin: EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: FileImage(
                                  greatPlaces.items[i].image,
                                ),
                              ),
                              title: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  greatPlaces.items[i].title,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8, left: 5, right: 5),
                                child:
                                    Text(greatPlaces.items[i].location.address),
                              ),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  PlaceDetailScreen.routeName,
                                  arguments: greatPlaces.items[i].id,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
              ),
      ),
    );
  }
}
