import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';

typedef PositionCallback<T> = FutureOr<Iterable<T>> Function(LatLng pattern);
typedef MarkerBuilder<T> = Marker Function(T itemData);