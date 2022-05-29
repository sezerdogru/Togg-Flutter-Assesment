import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:togg_case/const.dart';
import 'package:togg_case/service/poi.pb.dart';
import 'package:togg_case/service/service.locations.dart';

class Locations extends StatefulWidget {
  const Locations({Key? key}) : super(key: key);

  @override
  State<Locations> createState() => MarkerIconsBodyState();
}

const LatLng _kMapCenter = LatLng(52.4478, -3.5402);

class MarkerIconsBodyState extends State<Locations> {
  GoogleMapController? controller;
  BitmapDescriptor? _markerIcon;
  late List<PoiReply> locations;

  @override
  void initState() {
    super.initState();
    getLocations();
  }

  void getLocations() async {
    var locations = await LocationService.getPois();
    locations = await locations.toList();
    List<Marker> l = [];
    for (PoiReply element in locations) {
      Marker marker = createNewMarker(element);
      l.add(marker);
      print(marker);
    }

    setState(() {
      locations.addAll(l);
    });
  }

  createNewMarker(PoiReply element) {
    return Marker(
      markerId: MarkerId('marker_${element.id}'),
      position: LatLng(element.lat, element.lon),
      icon: _markerIcon!,
      onTap: () {
        controller?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(element.lat, element.lon),
              zoom: 18,
            ),
          ),
        );
        getLocations();
        showModalBottomSheet(
            context: context,
            builder: (builder) {
              return Container(
                child: _buildBottonNavigationMethod("element"),
              );
            });
      },
    );
  }

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
          getLocations();
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
