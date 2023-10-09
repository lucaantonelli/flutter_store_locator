import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../typedef.dart';
import 'map_configuration.dart';

/// A [GoogleMap](https://pub.dev/documentation/google_maps_flutter/latest/google_maps_flutter/google_maps_flutter-library.html)
/// implementation of [StoreLocator]
class StoreLocator<T> extends StatefulWidget {
  /// Called with the onCameraIdle to get update the list of map markers.
  ///
  /// This callback must not be null.
  /// It should return a [List](https://api.dartlang.org/stable/2.0.0/dart-core/List-class.html)
  /// of markers asynchronously (as the result of a
  /// [Future](https://api.dartlang.org/stable/dart-async/Future-class.html)).
  /// These entries will then be provided to [markerBuilder] to display
  /// the markers on the map.
  ///
  /// Example:
  /// ```dart
  /// positionCallback: (position) async {
  ///  Response response = await Dio(options).get('stores', queryParameters: {
  ///    "latitude": position.latitude,
  ///    "longitude": position.longitude,
  ///  });
  ///
  ///  if (response.statusCode == 200 || response.statusCode == 201) {
  ///    return storesFromJson(response.data);
  ///  }
  ///  return [];
  /// },
  /// ```
  final PositionCallback<T> positionCallback;

  /// Called for each marker returned by [positionCallback] to build the
  /// corresponding widget.
  ///
  /// This callback must not be null. It is called for
  /// each marker, and expected to build a widget to display this
  /// marker's info. For example:
  ///
  /// ```dart
  /// markerBuilder: (store) {
  ///  return Marker(
  ///   markerId: MarkerId(store.id.toString()),
  ///   position: LatLng(store.latitude, store.longitude),
  ///   infoWindow: InfoWindow(
  ///    title: store.name,
  ///    snippet: store.city,
  ///   ),
  ///  );
  /// }
  /// ```
  final MarkerBuilder<T> markerBuilder;

  /// The configuration of the [GoogleMaps](https://pub.dev/documentation/google_maps_flutter/latest/google_maps_flutter/google_maps_flutter-library.html)
  /// that the StoreLocator widget displays
  final MapConfiguration mapConfiguration;

  /// If set to true, the markers will reset on each camera movement through [GoogleMap.onCameraMove] callback.
  ///
  /// Defaults to false.
  final bool resetMarkers;

  /// Creates a [StoreLocator]
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
  /// It contains the current centered position on the map
  ///
  /// Default is set to initialCameraPosition.target inside initState
  late LatLng currentPosition;

  // Default to true to make the first request
  bool cameraMoved = true;

  // Contain the markers currently visible on the map
  Set<Marker> _markerSet = {};

  // Contain the markers returned by the positionCallback
  Iterable<T> _markers = [];
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
    // Get markers for the initial position
    _getMarkers();
  }

  // Called by the onCameraMove callback
  void _updatePosition(CameraPosition camera) {
    currentPosition = LatLng(camera.target.latitude, camera.target.longitude);
  }

  Future<void> _getMarkers() async {
    // To prevent execution in idle if no other movements were made
    if (!cameraMoved) return;

    if (mounted) {
      // setState(() {
      //   this._error = null;
      // });

      Iterable<T> markers = [];
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
          cameraMoved = false;
        });
      }
    }
  }

  Set<Marker> _buildMarkers() {
    // If resetMarkers is false set at default the current marker set
    final Set<Marker> markers = !widget.resetMarkers ? _markerSet : {};

    for (final T markerItem in _markers) {
      final Marker marker = widget.markerBuilder(markerItem);

      // If resetMarkers is false check wherever the marker position already exist
      if (!widget.resetMarkers) {
        // TODO: It is possible to check directly the entire marker (need to check)
        // bool markerExist = _markerSet.contains(marker);
        bool latitudeNotExist = _markerSet
            .where((item) => item.position.latitude == marker.position.latitude)
            .isEmpty;
        bool longitudeNotExist = _markerSet
            .where(
                (item) => item.position.longitude == marker.position.longitude)
            .isEmpty;
        if (latitudeNotExist && longitudeNotExist) {
          markers.add(marker);
        }
      } else {
        markers.add(marker);
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
