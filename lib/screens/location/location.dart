import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/utils/utils.dart';

class Location extends StatefulWidget {
  final LocationModel location;

  const Location({
    Key? key,
    required this.location,
  }) : super(key: key);

  @override
  _LocationState createState() {
    return _LocationState();
  }
}

class _LocationState extends State<Location> {
  final Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};

  @override
  void initState() {
    _onLoadMap();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///On load map
  void _onLoadMap() {
    final MarkerId markerId = MarkerId(widget.location.title);
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(widget.location.lat, widget.location.long),
      infoWindow: InfoWindow(title: widget.location.title),
      onTap: () {},
    );

    setState(() {
      _markers[markerId] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('location'),
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.location.lat, widget.location.long),
          zoom: 14.4746,
        ),
        markers: Set<Marker>.of(_markers.values),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
