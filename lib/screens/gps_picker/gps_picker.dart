import 'dart:async';

import 'package:animations/animations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

class GPSPicker extends StatefulWidget {
  final LocationModel? picked;

  const GPSPicker({Key? key, this.picked}) : super(key: key);

  @override
  _GPSPickerState createState() {
    return _GPSPickerState();
  }
}

class _GPSPickerState extends State<GPSPicker> {
  final _initPosition = const CameraPosition(
    target: LatLng(37.3325932, -121.9129757),
    zoom: 16,
  );
  final _markers = <MarkerId, Marker>{};
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    if (widget.picked != null) {
      _onSetMarker(
        latitude: widget.picked!.lat,
        longitude: widget.picked!.long,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///On Apply
  void _onApply() {
    final position = _markers.values.first.position;
    final title = widget.picked?.title ?? 'location';
    final item = LocationModel(
      title: title,
      long: position.longitude,
      lat: position.latitude,
    );
    Navigator.pop(context, item);
  }

  ///On set marker
  void _onSetMarker({
    required double latitude,
    required double longitude,
  }) async {
    final title = widget.picked?.title ?? 'location';
    final markerId = MarkerId(title);
    final position = LatLng(latitude, longitude);
    final Marker marker = Marker(
      markerId: markerId,
      position: position,
      infoWindow: InfoWindow(title: title),
    );

    setState(() {
      _markers[markerId] = marker;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: position,
          tilt: 30.0,
          zoom: 15.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('location'),
        ),
        actions: [
          TextButton(
            onPressed: _onApply,
            child: Text(
              Translate.of(context).translate('apply'),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              _mapController = controller;
            },
            initialCameraPosition: _initPosition,
            markers: Set<Marker>.of(_markers.values),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onTap: (item) {
              _onSetMarker(
                latitude: item.latitude,
                longitude: item.longitude,
              );
            },
          ),
          OpenContainer<bool>(
            openColor: Colors.transparent,
            closedColor: Colors.transparent,
            transitionType: ContainerTransitionType.fade,
            openBuilder: (context, closeContainer) {
              return GPSList(
                closeContainer: closeContainer,
                onSetMarker: _onSetMarker,
              );
            },
            closedShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            transitionDuration: const Duration(milliseconds: 500),
            closedElevation: 0.0,
            openElevation: 0.0,
            closedBuilder: (context, openContainer) {
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: const EdgeInsets.all(16),
                child: AppPickerItem(
                  leading: Icon(
                    Icons.search,
                    color: Theme.of(context).hintColor,
                  ),
                  title: Translate.of(context).translate(
                    'search',
                  ),
                  onPressed: openContainer,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class GPSList extends StatefulWidget {
  final Function closeContainer;
  final void Function({
    required double latitude,
    required double longitude,
  }) onSetMarker;

  const GPSList({
    Key? key,
    required this.closeContainer,
    required this.onSetMarker,
  }) : super(key: key);

  @override
  _GPSListState createState() {
    return _GPSListState();
  }
}

class _GPSListState extends State<GPSList> {
  final _textSearchController = TextEditingController();
  final _focusSearch = FocusNode();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 500), () {
      FocusScope.of(context).requestFocus(_focusSearch);
    });
  }

  @override
  void dispose() {
    _focusSearch.dispose();
    _textSearchController.dispose();
    super.dispose();
  }

  ///On Search Place
  void _onSearch(String input) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          Translate.of(context).translate('location'),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              AppTextInput(
                hintText: Translate.of(context).translate('search'),
                textInputAction: TextInputAction.done,
                focusNode: _focusSearch,
                controller: _textSearchController,
                onChanged: _onSearch,
                onSubmitted: _onSearch,
                leading: Icon(
                  Icons.search,
                  color: Theme.of(context).hintColor,
                ),
                trailing: GestureDetector(
                  dragStartBehavior: DragStartBehavior.down,
                  onTap: () {
                    _textSearchController.clear();
                  },
                  child: const Icon(Icons.clear),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
