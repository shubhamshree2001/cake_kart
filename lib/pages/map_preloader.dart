import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:notification/pages/map.dart';
import 'package:notification/services/geolocator_service.dart';
import 'package:provider/provider.dart';

class MapPreloaderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureProvider(
        create: (_) => GeolocatorService().getInitialLocation(),
        child: Consumer<Position>(
          builder: (context,position,widget) {
            return (position != null) 
            ? MapPage(pos: position,)
            : Center(child: CircularProgressIndicator(),)
            ;
          } 
        ),
      ),
    );
  }
}