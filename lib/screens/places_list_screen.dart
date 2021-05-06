import 'package:flutter/material.dart';
import 'package:great_places/providers/great_place.dart';
import 'package:provider/provider.dart';

import '../screens/add_place_screen.dart';
import '../providers/great_place.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Places'),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
            ),
          ],
        ),
        body: Consumer<GreatPlaces>(
          child: Center(
            child: Text('No Places Added yet, try adding some'),
          ),
          builder: (ctx, greatPlaces, ch) => greatPlaces.items.length <= 0
              ? ch
              : ListView.builder(
                  itemCount: greatPlaces.items.length,
                  itemBuilder: (ctx, index) => ListTile(
                    leading: CircleAvatar(
                      backgroundImage: FileImage(
                        greatPlaces.items[index].image,
                      ),
                    ),
                    title: Text(greatPlaces.items[index].title),
                    onTap: (){
                      //go to detail page...
                    },
                    
                  ),
                  
                ),
        ));
  }
}
