import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:store_locator/store_locator.dart';

void main() {
  testWidgets('loads markers for the latest camera position', (tester) async {
    final List<LatLng> requestedPositions = <LatLng>[];

    await tester.pumpWidget(
      _testApp(
        StoreLocator<int>(
          positionCallback: (LatLng position) {
            requestedPositions.add(position);
            return <int>[];
          },
          markerBuilder: _markerBuilder,
        ),
      ),
    );
    await tester.pump();

    const LatLng newPosition = LatLng(45.4642, 9.1900);
    GoogleMap map = tester.widget<GoogleMap>(find.byType(GoogleMap));
    map.onCameraMoveStarted?.call();
    map.onCameraMove?.call(const CameraPosition(target: newPosition, zoom: 12));
    map.onCameraIdle?.call();
    await tester.pump();

    expect(requestedPositions, <LatLng>[const LatLng(0, 0), newPosition]);
  });

  testWidgets('merges markers by MarkerId', (tester) async {
    int requestCount = 0;

    await tester.pumpWidget(
      _testApp(
        StoreLocator<int>(
          positionCallback: (LatLng position) {
            requestCount++;
            return requestCount == 1 ? <int>[1] : <int>[2];
          },
          markerBuilder: _markerBuilder,
        ),
      ),
    );
    await tester.pump();

    GoogleMap map = tester.widget<GoogleMap>(find.byType(GoogleMap));
    expect(map.markers.map((Marker marker) => marker.markerId), {
      const MarkerId('1'),
    });

    map.onCameraMoveStarted?.call();
    map.onCameraMove?.call(
      const CameraPosition(target: LatLng(1, 3), zoom: 12),
    );
    map.onCameraIdle?.call();
    await tester.pump();
    await tester.pump();

    map = tester.widget<GoogleMap>(find.byType(GoogleMap));
    expect(map.markers.map((Marker marker) => marker.markerId), {
      const MarkerId('1'),
      const MarkerId('2'),
    });
  });

  testWidgets('ignores stale asynchronous responses', (tester) async {
    final Completer<Iterable<int>> firstRequest = Completer<Iterable<int>>();
    final Completer<Iterable<int>> secondRequest = Completer<Iterable<int>>();
    int requestCount = 0;

    await tester.pumpWidget(
      _testApp(
        StoreLocator<int>(
          resetMarkers: true,
          positionCallback: (LatLng position) {
            requestCount++;
            return requestCount == 1
                ? firstRequest.future
                : secondRequest.future;
          },
          markerBuilder: _markerBuilder,
        ),
      ),
    );

    GoogleMap map = tester.widget<GoogleMap>(find.byType(GoogleMap));
    map.onCameraMoveStarted?.call();
    map.onCameraMove?.call(
      const CameraPosition(target: LatLng(2, 2), zoom: 12),
    );
    map.onCameraIdle?.call();

    secondRequest.complete(<int>[2]);
    await tester.pump();
    firstRequest.complete(<int>[1]);
    await tester.pump();

    map = tester.widget<GoogleMap>(find.byType(GoogleMap));
    expect(map.markers.single.markerId, const MarkerId('2'));
  });

  testWidgets('reports position callback errors', (tester) async {
    Object? reportedError;

    await tester.pumpWidget(
      _testApp(
        StoreLocator<int>(
          positionCallback: (LatLng position) => throw StateError('failed'),
          markerBuilder: _markerBuilder,
          onError: (Object error, StackTrace stackTrace) {
            reportedError = error;
          },
        ),
      ),
    );
    await tester.pump();

    expect(reportedError, isA<StateError>());
  });

  testWidgets('preserves markers from MapConfiguration', (tester) async {
    const Marker configuredMarker = Marker(
      markerId: MarkerId('configured'),
      position: LatLng(10, 10),
    );

    await tester.pumpWidget(
      _testApp(
        StoreLocator<int>(
          mapConfiguration: MapConfiguration(
            markers: <Marker>{configuredMarker},
          ),
          positionCallback: (LatLng position) => <int>[1],
          markerBuilder: _markerBuilder,
        ),
      ),
    );
    await tester.pump();

    final GoogleMap map = tester.widget<GoogleMap>(find.byType(GoogleMap));
    expect(map.markers.map((Marker marker) => marker.markerId), {
      const MarkerId('configured'),
      const MarkerId('1'),
    });
  });
}

Widget _testApp(Widget child) {
  return MaterialApp(
    home: Scaffold(body: SizedBox(width: 400, height: 400, child: child)),
  );
}

Marker _markerBuilder(int id) {
  return Marker(
    markerId: MarkerId('$id'),
    // Both markers intentionally share a latitude. The previous duplicate
    // detection incorrectly discarded the second marker in this case.
    position: LatLng(1, id.toDouble()),
  );
}
