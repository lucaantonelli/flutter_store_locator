import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';

typedef PositionCallback<T> = FutureOr<Iterable<T>> Function(LatLng position);
typedef MarkerBuilder<T> = Marker Function(T itemData);
typedef StoreLocatorErrorCallback =
    void Function(Object error, StackTrace stackTrace);
