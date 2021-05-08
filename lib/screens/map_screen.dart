import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../widgets/marker_address.dart';
import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  MapScreen({
    this.initialLocation =
        const PlaceLocation(latitude: 28.6049786337, longitude: 77.0985570231),
    this.isSelecting = false,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Set<Marker> _marker = {};
  LatLng _pickedLocation;
  String address;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
      _marker.add(Marker(
        markerId: MarkerId('m1'),
        position: LatLng(_pickedLocation.latitude, _pickedLocation.longitude) ??
            LatLng(
              widget.initialLocation.latitude,
              widget.initialLocation.longitude,
            ),
      
      ));
      Future<String> foo()async{
      return markerAdress(position.latitude, position.longitude);}

      foo().then((value)=>address=value);
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
        actions: <Widget>[
          if (widget.isSelecting)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: (_pickedLocation == null)
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedLocation);
                    },
            ),
        ],
      ),
      body: Column(
        children: [
          Card(
            elevation: 5,
            child: Container(
              width: double.infinity,
              child: Text(address ?? 'address'),
            ),
          ),
          Expanded(
            child: GoogleMap(
              scrollGesturesEnabled: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  widget.initialLocation.latitude,
                  widget.initialLocation.longitude,
                ),
                zoom: 20,
              ),
              onTap: widget.isSelecting ? _selectLocation : null,
              markers: _marker,
            ),
          ),
        ],
      ),
    );
  }
}
