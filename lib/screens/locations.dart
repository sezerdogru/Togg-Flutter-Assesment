import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:togg_case/const.dart';

class Locations extends StatefulWidget {
  const Locations({Key? key}) : super(key: key);

  @override
  State<Locations> createState() => MarkerIconsBodyState();
}

const LatLng _kMapCenter = LatLng(52.4478, -3.5402);

class MarkerIconsBodyState extends State<Locations> {
  GoogleMapController? controller;
  BitmapDescriptor? _markerIcon;

  @override
  Widget build(BuildContext context) {
    _createMarkerImageFromAsset(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(Const.locations),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 92,
              child: GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: _kMapCenter,
                  zoom: 7.0,
                ),
                markers: <Marker>{_createMarker()},
                onMapCreated: _onMapCreated,
              ),
            ),
          )
        ],
      ),
    );
  }

  Marker _createMarker() {
    if (_markerIcon != null) {
      return Marker(
        markerId: const MarkerId('marker_1'),
        position: _kMapCenter,
        icon: _markerIcon!,
        onTap: () {
          controller?.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(_kMapCenter.latitude, _kMapCenter.longitude),
                zoom: 18,
              ),
            ),
          );
          showModalBottomSheet(
              context: context,
              builder: (builder) {
                return Container(
                  child: _buildBottonNavigationMethod(""),
                );
              });
        },
      );
    } else {
      return const Marker(
        markerId: MarkerId('marker_1'),
        position: _kMapCenter,
      );
    }
  }

  Column _buildBottonNavigationMethod(String yourData) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const <Widget>[
        ListTile(
          leading: Icon(Icons.ac_unit),
          title: Text('Add as favourite'),
        )
      ],
    );
  }

  Future<void> _createMarkerImageFromAsset(BuildContext context) async {
    if (_markerIcon == null) {
      final ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context, size: const Size.square(48));
      BitmapDescriptor.fromAssetImage(
              imageConfiguration, 'assets/red_square.png')
          .then(_updateBitmap);
    }
  }

  void _updateBitmap(BitmapDescriptor bitmap) {
    setState(() {
      _markerIcon = bitmap;
    });
  }

  void _onMapCreated(GoogleMapController controllerParam) {
    setState(() {
      controller = controllerParam;
    });
  }
}
