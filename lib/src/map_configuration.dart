import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Supply an instance of this class to [StoreLocator.mapConfiguration]
/// A copy of [GoogleMap] configuration fields
class MapConfiguration {
  /// Same as [GoogleMap.initialCameraPosition]
  final CameraPosition initialCameraPosition;

  /// Same as [GoogleMap.onMapCreated]
  final void Function(GoogleMapController)? onMapCreated;

  /// Same as [GoogleMap.gestureRecognizers]
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;

  /// Same as [GoogleMap.webGestureHandling]
  final WebGestureHandling? webGestureHandling;

  /// Same as [GoogleMap.compassEnabled]
  final bool compassEnabled;

  /// Same as [GoogleMap.mapToolbarEnabled]
  final bool mapToolbarEnabled;

  /// Same as [GoogleMap.cameraTargetBounds]
  final CameraTargetBounds cameraTargetBounds;

  /// Same as [GoogleMap.mapType]
  final MapType mapType;

  /// Same as [GoogleMap.minMaxZoomPreference]
  final MinMaxZoomPreference minMaxZoomPreference;

  /// Same as [GoogleMap.rotateGesturesEnabled]
  final bool rotateGesturesEnabled;

  /// Same as [GoogleMap.scrollGesturesEnabled]
  final bool scrollGesturesEnabled;

  /// Same as [GoogleMap.zoomControlsEnabled]
  final bool zoomControlsEnabled;

  /// Same as [GoogleMap.zoomGesturesEnabled]
  final bool zoomGesturesEnabled;

  /// Same as [GoogleMap.liteModeEnabled]
  final bool liteModeEnabled;

  /// Same as [GoogleMap.tiltGesturesEnabled]
  final bool tiltGesturesEnabled;

  /// Same as [GoogleMap.fortyFiveDegreeImageryEnabled]
  final bool fortyFiveDegreeImageryEnabled;

  /// Same as [GoogleMap.myLocationEnabled]
  final bool myLocationEnabled;

  /// Same as [GoogleMap.myLocationButtonEnabled]
  final bool myLocationButtonEnabled;

  /// Same as [GoogleMap.layoutDirection]
  final TextDirection? layoutDirection;

  /// Same as [GoogleMap.padding]
  final EdgeInsets padding;

  /// Same as [GoogleMap.indoorViewEnabled]
  final bool indoorViewEnabled;

  /// Same as [GoogleMap.trafficEnabled]
  final bool trafficEnabled;

  /// Same as [GoogleMap.buildingsEnabled]
  final bool buildingsEnabled;

  /// Same as [GoogleMap.markers]
  final Set<Marker> markers;

  /// Same as [GoogleMap.polygons]
  final Set<Polygon> polygons;

  /// Same as [GoogleMap.polylines]
  final Set<Polyline> polylines;

  /// Same as [GoogleMap.circles]
  final Set<Circle> circles;

  /// Same as [GoogleMap.onCameraMoveStarted]
  final void Function()? onCameraMoveStarted;

  /// Same as [GoogleMap.tileOverlays]
  final Set<TileOverlay> tileOverlays;

  /// Same as [GoogleMap.onCameraMove]
  final void Function(CameraPosition)? onCameraMove;

  /// Same as [GoogleMap.onCameraIdle]
  final void Function()? onCameraIdle;

  /// Same as [GoogleMap.onTap]
  final void Function(LatLng)? onTap;

  /// Same as [GoogleMap.onLongPress]
  final void Function(LatLng)? onLongPress;

  /// Same as [GoogleMap.cloudMapId]
  final String? cloudMapId;

  /// Creates a MapConfiguration
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
    this.onCameraMoveStarted,
    this.tileOverlays = const <TileOverlay>{},
    this.onCameraMove,
    this.onCameraIdle,
    this.onTap,
    this.onLongPress,
    this.cloudMapId,
  });

  /// Copies the [MapConfiguration] and only changes the specified
  /// properties
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
    void Function()? onCameraMoveStarted,
    Set<TileOverlay>? tileOverlays,
    void Function(CameraPosition)? onCameraMove,
    void Function()? onCameraIdle,
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
        onCameraMoveStarted: onCameraMoveStarted ?? this.onCameraMoveStarted,
        tileOverlays: tileOverlays ?? this.tileOverlays,
        onCameraMove: onCameraMove ?? this.onCameraMove,
        onCameraIdle: onCameraIdle ?? this.onCameraIdle,
        onTap: onTap ?? this.onTap,
        onLongPress: onLongPress ?? this.onLongPress,
        cloudMapId: cloudMapId ?? this.cloudMapId,
      );
}
