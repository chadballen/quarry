import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:user_location/user_location.dart';
import 'package:latlong/latlong.dart';

class MyMap extends StatelessWidget {
  MapController mapController = MapController();
  UserLocationOptions userLocationOptions;
  List<Marker> markers = [];

  @override
  Widget build(BuildContext context) {
    userLocationOptions = UserLocationOptions(
      context: context,
      mapController: mapController,
      markers: markers,
    );
    return Container(
        child: FlutterMap(
      options: MapOptions(center: LatLng(0, 0), zoom: 15.0, plugins: [
        UserLocationPlugin(),
      ]),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://api.tiles.mapbox.com/v4/"
              "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
          additionalOptions: {
            'accessToken':
                'pk.eyJ1IjoiZmF1Z2UiLCJhIjoiY2s3ZHd2dGJ6MDJqazNrbzM2cjZoOWJ3bCJ9.yr0QIGWPzhUNBV35FGeL8A',
            'id': 'mapbox.streets',
          },
        ),
        MarkerLayerOptions(markers: markers),
        userLocationOptions,
      ],
      mapController: mapController,
    ));
  }
}
