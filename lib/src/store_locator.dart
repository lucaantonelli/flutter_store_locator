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

  /// Called when [positionCallback] throws.
  final StoreLocatorErrorCallback? onError;

  /// The configuration of the [GoogleMaps](https://pub.dev/documentation/google_maps_flutter/latest/google_maps_flutter/google_maps_flutter-library.html)
  /// that the StoreLocator widget displays
  final MapConfiguration mapConfiguration;

  /// If set to true, the markers will reset on each camera movement through [GoogleMap.onCameraMove] callback.
  ///
  /// Defaults to false.
  final bool resetMarkers;

  /// Creates a [StoreLocator]
  const StoreLocator({
    super.key,
    required this.positionCallback,
    required this.markerBuilder,
    this.onError,
    this.mapConfiguration = const MapConfiguration(),
    this.resetMarkers = false,
  });

  @override
  State<StoreLocator<T>> createState() => _StoreLocatorState<T>();
}

class _StoreLocatorState<T> extends State<StoreLocator<T>> {
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

  int _cameraGeneration = 0;

  @override
  void initState() {
    super.initState();
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

    cameraMoved = false;
    final int requestGeneration = _cameraGeneration;
    final LatLng requestedPosition = currentPosition;

    late final Iterable<T> markers;
    try {
      markers = await widget.positionCallback(requestedPosition);
    } catch (error, stackTrace) {
      widget.onError?.call(error, stackTrace);
      return;
    }

    // Ignore a response for a camera position that is no longer current.
    if (!mounted || requestGeneration != _cameraGeneration) return;

    setState(() {
      _markers = markers;
      _markerSet = _buildMarkers();
    });
  }

  Set<Marker> _buildMarkers() {
    final Map<MarkerId, Marker> markersById = widget.resetMarkers
        ? <MarkerId, Marker>{}
        : <MarkerId, Marker>{
            for (final Marker marker in _markerSet) marker.markerId: marker,
          };

    for (final T markerItem in _markers) {
      final Marker marker = widget.markerBuilder(markerItem);
      markersById[marker.markerId] = marker;
    }

    return markersById.values.toSet();
  }

  Set<Marker> get _visibleMarkers => <MarkerId, Marker>{
    for (final Marker marker in widget.mapConfiguration.markers)
      marker.markerId: marker,
    for (final Marker marker in _markerSet) marker.markerId: marker,
  }.values.toSet();

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      markers: _visibleMarkers,
      initialCameraPosition: widget.mapConfiguration.initialCameraPosition,
      style: widget.mapConfiguration.style,
      onMapCreated: widget.mapConfiguration.onMapCreated,
      gestureRecognizers: widget.mapConfiguration.gestureRecognizers,
      webGestureHandling: widget.mapConfiguration.webGestureHandling,
      webCameraControlPosition:
          widget.mapConfiguration.webCameraControlPosition,
      webCameraControlEnabled: widget.mapConfiguration.webCameraControlEnabled,
      mapTypeControlEnabled: widget.mapConfiguration.mapTypeControlEnabled,
      fullscreenControlEnabled:
          widget.mapConfiguration.fullscreenControlEnabled,
      streetViewControlEnabled:
          widget.mapConfiguration.streetViewControlEnabled,
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
      clusterManagers: widget.mapConfiguration.clusterManagers,
      heatmaps: widget.mapConfiguration.heatmaps,
      onCameraMoveStarted: () {
        _cameraGeneration++;
        cameraMoved = true;
        widget.mapConfiguration.onCameraMoveStarted?.call();
      },
      tileOverlays: widget.mapConfiguration.tileOverlays,
      groundOverlays: widget.mapConfiguration.groundOverlays,
      onCameraMove: (camera) {
        _updatePosition(camera);
        widget.mapConfiguration.onCameraMove?.call(camera);
      },
      onCameraIdle: () {
        _getMarkers();
        widget.mapConfiguration.onCameraIdle?.call();
      },
      onTap: widget.mapConfiguration.onTap,
      onLongPress: widget.mapConfiguration.onLongPress,
      markerType: widget.mapConfiguration.markerType,
      colorScheme: widget.mapConfiguration.colorScheme,
      mapId: widget.mapConfiguration.mapId,
    );
  }
}
