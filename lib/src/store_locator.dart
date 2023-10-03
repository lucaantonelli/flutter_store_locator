import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:store_locator/src/map/map_configuration.dart';
import 'package:store_locator/typedef.dart';

class StoreLocator<T> extends StatefulWidget {
  final PositionCallback<T> positionCallback;
  final MarkerBuilder<T> markerBuilder;
  final MapConfiguration mapConfiguration;
  final bool resetMarkers;

  const StoreLocator({
    Key? key,
    required this.positionCallback,
    required this.markerBuilder,
    this.mapConfiguration = const MapConfiguration(),
    this.resetMarkers = false,
  }) : super(key: key);

  @override
  State<StoreLocator<T>> createState() => _StoreLocatorState<T>();
}

class _StoreLocatorState<T> extends State<StoreLocator<T>>
    with WidgetsBindingObserver {
  late LatLng currentPosition;

  // Default to true to make the first request
  bool cameraMoved = true;

  // Contain the markers currently visible on the map
  Set<Marker> _markerSet = {};

  Iterable<T>? _markers;
  // Object? _error;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    currentPosition = widget.mapConfiguration.initialCameraPosition.target;
    _getMarkers();
  }

  void _updatePosition(CameraPosition camera) {
    currentPosition = LatLng(camera.target.latitude, camera.target.longitude);
  }

  Future<void> _getMarkers() async {
    if (!cameraMoved) return;

    if (mounted) {
      setState(() {
        cameraMoved = false;
        // this._error = null;
      });

      Iterable<T>? markers;
      // Object? error;

      try {
        markers = await widget.positionCallback(currentPosition);
      } catch (e) {
        // error = e;
      }

      if (mounted) {
        setState(() {
          // this._error = error;
          _markers = markers;
          _markerSet = _buildMarkers();
        });
      }
    }
  }

  Set<Marker> _buildMarkers() {
    // If resetMarkers is false set at default the current marker set
    final Set<Marker> markers = !widget.resetMarkers ? _markerSet : {};

    if (_markers != null) {
      for (final T markerItem in _markers!) {
        final Marker marker = widget.markerBuilder(markerItem);

        // If resetMarkers is false check wherever the marker position already exist
        if (!widget.resetMarkers) {
          // TODO: It is possible to check directly the entire marker (need to check)
          // bool markerExist = _markerSet.contains(marker);
          bool latitudeNotExist = _markerSet
              .where(
                  (item) => item.position.latitude == marker.position.latitude)
              .isEmpty;
          bool longitudeNotExist = _markerSet
              .where((item) =>
                  item.position.longitude == marker.position.longitude)
              .isEmpty;
          if (latitudeNotExist && longitudeNotExist) {
            markers.add(marker);
          }
        } else {
          markers.add(marker);
        }
      }
    }

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      markers: _markerSet,
      initialCameraPosition: widget.mapConfiguration.initialCameraPosition,
      onMapCreated: widget.mapConfiguration.onMapCreated,
      gestureRecognizers: widget.mapConfiguration.gestureRecognizers,
      webGestureHandling: widget.mapConfiguration.webGestureHandling,
      compassEnabled: widget.mapConfiguration.compassEnabled,
      mapToolbarEnabled: widget.mapConfiguration.mapToolbarEnabled,
      cameraTargetBounds: widget.mapConfiguration.cameraTargetBounds,
      mapType: widget.mapConfiguration.mapType,
      minMaxZoomPreference: widget.mapConfiguration.minMaxZoomPreference,
      rotateGesturesEnabled: widget.mapConfiguration.rotateGesturesEnabled,
      scrollGesturesEnabled: widget.mapConfiguration.scrollGesturesEnabled,
      zoomControlsEnabled: widget.mapConfiguration.zoomControlsEnabled,
      zoomGesturesEnabled: widget.mapConfiguration.zoomGesturesEnabled,
      liteModeEnabled: widget.mapConfiguration.liteModeEnabled,
      tiltGesturesEnabled: widget.mapConfiguration.tiltGesturesEnabled,
      fortyFiveDegreeImageryEnabled:
          widget.mapConfiguration.fortyFiveDegreeImageryEnabled,
      myLocationEnabled: widget.mapConfiguration.myLocationEnabled,
      myLocationButtonEnabled: widget.mapConfiguration.myLocationButtonEnabled,
      layoutDirection: widget.mapConfiguration.layoutDirection,
      padding: widget.mapConfiguration.padding,
      indoorViewEnabled: widget.mapConfiguration.indoorViewEnabled,
      trafficEnabled: widget.mapConfiguration.trafficEnabled,
      buildingsEnabled: widget.mapConfiguration.buildingsEnabled,
      polygons: widget.mapConfiguration.polygons,
      polylines: widget.mapConfiguration.polylines,
      circles: widget.mapConfiguration.circles,
      tileOverlays: widget.mapConfiguration.tileOverlays,
      onTap: widget.mapConfiguration.onTap,
      onLongPress: widget.mapConfiguration.onLongPress,
      cloudMapId: widget.mapConfiguration.cloudMapId,
      onCameraMoveStarted: () {
        setState(() => cameraMoved = true);
      },
      onCameraMove: _updatePosition,
      onCameraIdle: _getMarkers,
    );
  }
}
