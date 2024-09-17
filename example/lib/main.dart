import 'package:dio/dio.dart';
import 'package:example/store_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:store_locator/store_locator.dart';
import 'dart:ui' as ui;

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const StoreLocatorDemo(title: 'Store Locator Demo'),
    );
  }
}

class StoreLocatorDemo extends StatefulWidget {
  const StoreLocatorDemo({super.key, required this.title});

  final String title;

  @override
  State<StoreLocatorDemo> createState() => _StoreLocatorDemoState();
}

class _StoreLocatorDemoState extends State<StoreLocatorDemo> {
  static const String url =
      "https://627bb38fa01c46a853238cb9.mockapi.io/api/v1/";

  BitmapDescriptor? customMarker;

  static BaseOptions options =
      BaseOptions(baseUrl: url, responseType: ResponseType.json);

  @override
  void initState() {
    super.initState();
    getMarkerIcon();
  }

  Future<void> getMarkerIcon() async {
    ByteData data = await rootBundle.load('assets/marker.png');
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: 100);
    ui.FrameInfo fi = await codec.getNextFrame();
    final Uint8List markerIcon =
        (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
            .buffer
            .asUint8List();
    setState(() {
      customMarker = BitmapDescriptor.bytes(markerIcon);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: StoreLocator<Store>(
          resetMarkers: false,
          mapConfiguration: const MapConfiguration(
            initialCameraPosition: CameraPosition(
              target: LatLng(43.2116397, 13.6077776),
              zoom: 10,
            ),
          ),
          positionCallback: (position) async {
            // You can pass latitude and longitude like that:
            // Response response = await Dio(options).get('stores', queryParameters: {
            //   "latitude": position.latitude,
            //   "longitude": position.longitude,
            // });

            Response response = await Dio(options).get('stores');
            if (response.statusCode == 200 || response.statusCode == 201) {
              return storesFromJson(response.data);
            }
            return [];
          },
          markerBuilder: (store) {
            return Marker(
              markerId: MarkerId(store.id.toString()),
              icon: customMarker ?? BitmapDescriptor.defaultMarker,
              position: LatLng(store.latitude, store.longitude),
              infoWindow: InfoWindow(
                title: store.name,
                snippet: store.city,
              ),
            );
          },
        ),
      ),
    );
  }
}
