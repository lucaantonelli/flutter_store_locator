import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Supply an instance of this class to [StoreLocator.mapConfiguration]
/// A copy of [GoogleMap] configuration fields
class MapConfiguration {
  /// Same as [GoogleMap.initialCameraPosition]
  final CameraPosition initialCameraPosition;

  /// Same as [GoogleMap.style]
  final String? style;

  /// Same as [GoogleMap.onMapCreated]
  final void Function(GoogleMapController)? onMapCreated;

  /// Same as [GoogleMap.gestureRecognizers]
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;

  /// Same as [GoogleMap.webGestureHandling]
  final WebGestureHandling? webGestureHandling;

  /// Same as [GoogleMap.webCameraControlPosition]
  final WebCameraControlPosition? webCameraControlPosition;

  /// Same as [GoogleMap.webCameraControlEnabled]
  final bool webCameraControlEnabled;

  /// Same as [GoogleMap.mapTypeControlEnabled]
  final bool mapTypeControlEnabled;

  /// Same as [GoogleMap.fullscreenControlEnabled]
  final bool fullscreenControlEnabled;

  /// Same as [GoogleMap.streetViewControlEnabled]
  final bool streetViewControlEnabled;

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

  /// Same as [GoogleMap.clusterManagers]
  final Set<ClusterManager> clusterManagers;

  /// Same as [GoogleMap.heatmaps]
  final Set<Heatmap> heatmaps;

  /// Same as [GoogleMap.onCameraMoveStarted]
  final void Function()? onCameraMoveStarted;

  /// Same as [GoogleMap.tileOverlays]
  final Set<TileOverlay> tileOverlays;

  /// Same as [GoogleMap.groundOverlays]
  final Set<GroundOverlay> groundOverlays;

  /// Same as [GoogleMap.onCameraMove]
  final void Function(CameraPosition)? onCameraMove;

  /// Same as [GoogleMap.onCameraIdle]
  final void Function()? onCameraIdle;

  /// Same as [GoogleMap.onTap]
  final void Function(LatLng)? onTap;

  /// Same as [GoogleMap.onLongPress]
  final void Function(LatLng)? onLongPress;

  /// Same as [GoogleMap.markerType]
  final GoogleMapMarkerType markerType;

  /// Same as [GoogleMap.colorScheme]
  final MapColorScheme? colorScheme;

  /// Same as [GoogleMap.mapId]
  final String? mapId;

  /// Backward-compatible alias for [mapId].
  @Deprecated('Use mapId instead.')
  String? get cloudMapId => mapId;

  /// Creates a MapConfiguration
  const MapConfiguration({
    this.initialCameraPosition = const CameraPosition(target: LatLng(0.0, 0.0)),
    this.style,
    this.onMapCreated,
    this.gestureRecognizers = const <Factory<OneSequenceGestureRecognizer>>{},
    this.webGestureHandling,
    this.webCameraControlPosition,
    this.webCameraControlEnabled = true,
    this.mapTypeControlEnabled = true,
    this.fullscreenControlEnabled = true,
    this.streetViewControlEnabled = true,
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
    this.clusterManagers = const <ClusterManager>{},
    this.heatmaps = const <Heatmap>{},
    this.onCameraMoveStarted,
    this.tileOverlays = const <TileOverlay>{},
    this.groundOverlays = const <GroundOverlay>{},
    this.onCameraMove,
    this.onCameraIdle,
    this.onTap,
    this.onLongPress,
    this.markerType = GoogleMapMarkerType.marker,
    this.colorScheme,
    String? mapId,
    @Deprecated('Use mapId instead.') String? cloudMapId,
  }) : assert(
         mapId == null || cloudMapId == null,
         'Provide either mapId or cloudMapId, not both.',
       ),
       mapId = mapId ?? cloudMapId;

  /// Copies the [MapConfiguration] and only changes the specified
  /// properties
  MapConfiguration copyWith({
    CameraPosition? initialCameraPosition,
    String? style,
    void Function(GoogleMapController)? onMapCreated,
    Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers,
    WebGestureHandling? webGestureHandling,
    WebCameraControlPosition? webCameraControlPosition,
    bool? webCameraControlEnabled,
    bool? mapTypeControlEnabled,
    bool? fullscreenControlEnabled,
    bool? streetViewControlEnabled,
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
    Set<ClusterManager>? clusterManagers,
    Set<Heatmap>? heatmaps,
    void Function()? onCameraMoveStarted,
    Set<TileOverlay>? tileOverlays,
    Set<GroundOverlay>? groundOverlays,
    void Function(CameraPosition)? onCameraMove,
    void Function()? onCameraIdle,
    void Function(LatLng)? onTap,
    void Function(LatLng)? onLongPress,
    GoogleMapMarkerType? markerType,
    MapColorScheme? colorScheme,
    String? mapId,
    @Deprecated('Use mapId instead.') String? cloudMapId,
  }) => MapConfiguration(
    initialCameraPosition: initialCameraPosition ?? this.initialCameraPosition,
    style: style ?? this.style,
    onMapCreated: onMapCreated ?? this.onMapCreated,
    gestureRecognizers: gestureRecognizers ?? this.gestureRecognizers,
    webGestureHandling: webGestureHandling ?? this.webGestureHandling,
    webCameraControlPosition:
        webCameraControlPosition ?? this.webCameraControlPosition,
    webCameraControlEnabled:
        webCameraControlEnabled ?? this.webCameraControlEnabled,
    mapTypeControlEnabled: mapTypeControlEnabled ?? this.mapTypeControlEnabled,
    fullscreenControlEnabled:
        fullscreenControlEnabled ?? this.fullscreenControlEnabled,
    streetViewControlEnabled:
        streetViewControlEnabled ?? this.streetViewControlEnabled,
    compassEnabled: compassEnabled ?? this.compassEnabled,
    mapToolbarEnabled: mapToolbarEnabled ?? this.mapToolbarEnabled,
    cameraTargetBounds: cameraTargetBounds ?? this.cameraTargetBounds,
    mapType: mapType ?? this.mapType,
    minMaxZoomPreference: minMaxZoomPreference ?? this.minMaxZoomPreference,
    rotateGesturesEnabled: rotateGesturesEnabled ?? this.rotateGesturesEnabled,
    scrollGesturesEnabled: scrollGesturesEnabled ?? this.scrollGesturesEnabled,
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
    clusterManagers: clusterManagers ?? this.clusterManagers,
    heatmaps: heatmaps ?? this.heatmaps,
    onCameraMoveStarted: onCameraMoveStarted ?? this.onCameraMoveStarted,
    tileOverlays: tileOverlays ?? this.tileOverlays,
    groundOverlays: groundOverlays ?? this.groundOverlays,
    onCameraMove: onCameraMove ?? this.onCameraMove,
    onCameraIdle: onCameraIdle ?? this.onCameraIdle,
    onTap: onTap ?? this.onTap,
    onLongPress: onLongPress ?? this.onLongPress,
    markerType: markerType ?? this.markerType,
    colorScheme: colorScheme ?? this.colorScheme,
    mapId: mapId ?? cloudMapId ?? this.mapId,
  );
}
