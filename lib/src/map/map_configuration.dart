import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Supply an instance of this class to [StoreLocator.mapConfiguration]
/// A copy of [GoogleMap] configuration fields
class MapConfiguration {
  final CameraPosition initialCameraPosition;
  final void Function(GoogleMapController)? onMapCreated;
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;
  final WebGestureHandling? webGestureHandling;
  final bool compassEnabled;
  final bool mapToolbarEnabled;
  final CameraTargetBounds cameraTargetBounds;
  final MapType mapType;
  final MinMaxZoomPreference minMaxZoomPreference;
  final bool rotateGesturesEnabled;
  final bool scrollGesturesEnabled;
  final bool zoomControlsEnabled;
  final bool zoomGesturesEnabled;
  final bool liteModeEnabled;
  final bool tiltGesturesEnabled;
  final bool fortyFiveDegreeImageryEnabled;
  final bool myLocationEnabled;
  final bool myLocationButtonEnabled;
  final TextDirection? layoutDirection;
  final EdgeInsets padding;
  final bool indoorViewEnabled;
  final bool trafficEnabled;
  final bool buildingsEnabled;
  final Set<Marker> markers;
  final Set<Polygon> polygons;
  final Set<Polyline> polylines;
  final Set<Circle> circles;
  final Set<TileOverlay> tileOverlays;
  final void Function(LatLng)? onTap;
  final void Function(LatLng)? onLongPress;
  final String? cloudMapId;

  const MapConfiguration({
    this.initialCameraPosition = const CameraPosition(
      target: LatLng(0.0, 0.0),
    ),
    this.onMapCreated,
    this.gestureRecognizers = const <Factory<OneSequenceGestureRecognizer>>{},
    this.webGestureHandling,
    this.compassEnabled = true,
    this.mapToolbarEnabled = true,
    this.cameraTargetBounds = CameraTargetBounds.unbounded,
    this.mapType = MapType.normal,
    this.minMaxZoomPreference = MinMaxZoomPreference.unbounded,
    this.rotateGesturesEnabled = true,
    this.scrollGesturesEnabled = true,
    this.zoomControlsEnabled = true,
    this.zoomGesturesEnabled = true,
    this.liteModeEnabled = false,
    this.tiltGesturesEnabled = true,
    this.fortyFiveDegreeImageryEnabled = false,
    this.myLocationEnabled = false,
    this.myLocationButtonEnabled = true,
    this.layoutDirection,
    this.padding = EdgeInsets.zero,
    this.indoorViewEnabled = false,
    this.trafficEnabled = false,
    this.buildingsEnabled = true,
    this.markers = const <Marker>{},
    this.polygons = const <Polygon>{},
    this.polylines = const <Polyline>{},
    this.circles = const <Circle>{},
    this.tileOverlays = const <TileOverlay>{},
    this.onTap,
    this.onLongPress,
    this.cloudMapId,
  });

  MapConfiguration copyWith({
    CameraPosition? initialCameraPosition,
    void Function(GoogleMapController)? onMapCreated,
    Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers,
    WebGestureHandling? webGestureHandling,
    bool? compassEnabled,
    bool? mapToolbarEnabled,
    CameraTargetBounds? cameraTargetBounds,
    MapType? mapType,
    MinMaxZoomPreference? minMaxZoomPreference,
    bool? rotateGesturesEnabled,
    bool? scrollGesturesEnabled,
    bool? zoomControlsEnabled,
    bool? zoomGesturesEnabled,
    bool? liteModeEnabled,
    bool? tiltGesturesEnabled,
    bool? fortyFiveDegreeImageryEnabled,
    bool? myLocationEnabled,
    bool? myLocationButtonEnabled,
    TextDirection? layoutDirection,
    EdgeInsets? padding,
    bool? indoorViewEnabled,
    bool? trafficEnabled,
    bool? buildingsEnabled,
    Set<Marker>? markers,
    Set<Polygon>? polygons,
    Set<Polyline>? polylines,
    Set<Circle>? circles,
    Set<TileOverlay>? tileOverlays,
    void Function(LatLng)? onTap,
    void Function(LatLng)? onLongPress,
    String? cloudMapId,
  }) =>
      MapConfiguration(
        initialCameraPosition:
            initialCameraPosition ?? this.initialCameraPosition,
        onMapCreated: onMapCreated ?? this.onMapCreated,
        gestureRecognizers: gestureRecognizers ?? this.gestureRecognizers,
        webGestureHandling: webGestureHandling ?? this.webGestureHandling,
        compassEnabled: compassEnabled ?? this.compassEnabled,
        mapToolbarEnabled: mapToolbarEnabled ?? this.mapToolbarEnabled,
        cameraTargetBounds: cameraTargetBounds ?? this.cameraTargetBounds,
        mapType: mapType ?? this.mapType,
        minMaxZoomPreference: minMaxZoomPreference ?? this.minMaxZoomPreference,
        rotateGesturesEnabled:
            rotateGesturesEnabled ?? this.rotateGesturesEnabled,
        scrollGesturesEnabled:
            scrollGesturesEnabled ?? this.scrollGesturesEnabled,
        zoomControlsEnabled: zoomControlsEnabled ?? this.zoomControlsEnabled,
        zoomGesturesEnabled: zoomGesturesEnabled ?? this.zoomGesturesEnabled,
        liteModeEnabled: liteModeEnabled ?? this.liteModeEnabled,
        tiltGesturesEnabled: tiltGesturesEnabled ?? this.tiltGesturesEnabled,
        fortyFiveDegreeImageryEnabled:
            fortyFiveDegreeImageryEnabled ?? this.fortyFiveDegreeImageryEnabled,
        myLocationEnabled: myLocationEnabled ?? this.myLocationEnabled,
        myLocationButtonEnabled:
            myLocationButtonEnabled ?? this.myLocationButtonEnabled,
        layoutDirection: layoutDirection ?? this.layoutDirection,
        padding: padding ?? this.padding,
        indoorViewEnabled: indoorViewEnabled ?? this.indoorViewEnabled,
        trafficEnabled: trafficEnabled ?? this.trafficEnabled,
        buildingsEnabled: buildingsEnabled ?? this.buildingsEnabled,
        markers: markers ?? this.markers,
        polygons: polygons ?? this.polygons,
        polylines: polylines ?? this.polylines,
        circles: circles ?? this.circles,
        tileOverlays: tileOverlays ?? this.tileOverlays,
        onTap: onTap ?? this.onTap,
        onLongPress: onLongPress ?? this.onLongPress,
        cloudMapId: cloudMapId ?? this.cloudMapId,
      );
}
