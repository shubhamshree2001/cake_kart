import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:notification/providers/address.dart';
import 'package:notification/providers/map.dart';
import 'package:provider/provider.dart';
import 'package:search_map_place/search_map_place.dart';

class MapPage extends StatefulWidget {

  final Position pos;

  MapPage({this.pos});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  GoogleMapController mapController;
  Position markerPosition;

  void loadAddress() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(markerPosition.latitude, markerPosition.longitude, localeIdentifier: "en")
    .then((value) {
      final _mapProvider = Provider.of<MapProvider>(context,listen: false);
      _mapProvider.setAddress(
        name: value[0].name.toString(),
        postalCode: value[0].postalCode.toString(),
        administrativeArea: value[0].administrativeArea.toString(),
        sublocality: value[0].subLocality.toString(),
        locality: value[0].locality.toString(),
      );
      final _addressProvider = Provider.of<AddressProvider>(context,listen: false);
      _addressProvider.addressLine1 =  value[0].postalCode.toString()+", "+value[0].name.toString();
      _addressProvider.addressLine2 =  value[0].administrativeArea.toString() + ", " + value[0].subLocality.toString();
      _addressProvider.addressLine3 =  value[0].locality.toString();
    })
    .catchError((e){
      print("----------------");
      print(e.toString());
    });
  }
  
  @override

  void initState() {
    super.initState();
    markerPosition = widget.pos;
    loadAddress();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),iconSize: 16, 
          onPressed: () {
            Get.back();
          }),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Set Delivery Location",
          style: GoogleFonts.roboto(
            fontSize: 17
          ),
        ),
      ),
      body: _loadMap(context,widget.pos), 
    );
  }

  Widget _loadMap(BuildContext context,Position pos) {
    final _addressProvider = Provider.of<MapProvider>(context);
    final _addressMap = _addressProvider.address;
    return Column(
      children: [
        // _buildSearchBar(context),
        Expanded(
          child: Container(
            margin: EdgeInsets.fromLTRB(12,0,12,12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                width: 1,
                color: Colors.blueAccent[700],
              ),
            ),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: GoogleMap(
                  onMapCreated: (GoogleMapController googleMapController) {
                    setState(() {
                      mapController = googleMapController;
                    });
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(pos.latitude,pos.longitude),
                    zoom: 18.9, 
                  ),
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  markers: Set.of(
                    <Marker>[
                      Marker(
                        draggable: true,
                        markerId: MarkerId("1"),
                        position: LatLng(markerPosition.latitude, markerPosition.longitude),
                        icon: BitmapDescriptor.defaultMarker,
                      ),
                    ],
                  ),
                  onCameraMove: (newPosition) {
                    setState(() {
                      markerPosition = new Position(latitude: newPosition.target.latitude,longitude: newPosition.target.longitude);
                    });
                    //loadAddress();
                  },
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(12,0,12,12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(12)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: _addressProvider.checkIfNull() 
                ?Center(child: CircularProgressIndicator(),)
                :Text(
                  "${_addressMap["postalCode"]}, ${_addressMap["name"]}, ${_addressMap["sublocality"]}, ${_addressMap["locality"]}, ${_addressMap["administrativeArea"]}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 13,
                  ),
                ),
              ),
              Material(
                color: Colors.blueAccent[700],
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                child: Container(
                  child: InkWell(
                    onTap: () {
                      loadAddress();
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        )
                      ),
                      child: Text(
                        "Get Location ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 17,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ]
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: SearchMapPlaceWidget(
        hasClearButton: true,
        placeType: PlaceType.address,
        placeholder: "Search location",
        apiKey: "AIzaSyDWpZJEGsuxvo58_SsYoShcNqduJu04Z_4",
        onSelected: (Place place) async {
          Geolocation geolocation = await place.geolocation.catchError(
            (e){printError(info:e);}
          );
          mapController.animateCamera( 
            CameraUpdate.newLatLng(
              geolocation.coordinates
            )
          );
          mapController.animateCamera(
            CameraUpdate.newLatLngBounds(geolocation.bounds,0)
          );
        },
      ),
    );
  }

}