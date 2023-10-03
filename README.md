# Store Locator plugin for Flutter

[![pub package](https://img.shields.io/pub/v/store_locator.svg)](https://pub.dev/packages/store_locator) [![build](https://img.shields.io/badge/build-passing-brightgreen)](https://pub.dev/packages/store_locator)

A Flutter plugin for iOS and Android for showing map markers dynamically based on Api Call that use haversine or similar.

|             | Android | iOS   | Web   |
|-------------|---------|-------|-------|
| **Support** | SDK 20+ | 11.0+ | Any\* |

![The example app running in Android](https://github.com/lucaantonelli/flutter_store_locator/blob/master/resources/demo.gif?raw=true)

## Installation

First, add `store_locator` as a [dependency in your pubspec.yaml file](https://flutter.dev/using-packages/).

You also need to implement `google_maps_flutter` properly, check their [guide](https://pub.dev/packages/google_maps_flutter)

## Import

You can import the package with:

```dart
import 'package:flutter_typeahead/flutter_typeahead.dart';
```

## Example

```dart
StoreLocator<Store>(
	mapConfiguration: const MapConfiguration(
		initialCameraPosition: CameraPosition(
			target: LatLng(45.464211, 9.191383),
			zoom: 10,
		),
	),
	positionCallback: (position) async {
		Response response = await Dio().get('stores', queryParameters: {
			"latitude": position.latitude,
      "longitude": position.longitude,
		});
		if (response.statusCode == 200 || response.statusCode == 201) {
			return storesFromJson(response.data);
		}
		return [];
	},
	markerBuilder: (store) {
		return Marker(
			markerId: MarkerId(store.id.toString()),
			position: LatLng(store.latitude, store.longitude),
			infoWindow: InfoWindow(
				title: store.name,
				snippet: store.city,
			),
		);
	},
)
```

See the `example` directory for a complete sample app.

## Support

If this plugin was useful to you, helped you to deliver your app, saved you a lot of time, or you just want to support the project, I would be very grateful if you buy me a cup of coffee.

[![Buy Me A Coffee](https://www.buymeacoffee.com/assets/img/custom_images/yellow_img.png)](https://www.buymeacoffee.com/lucaantonelli)

## License

[MIT](https://github.com/lucaantonelli/flutter_store_locator/blob/master/LICENSE)