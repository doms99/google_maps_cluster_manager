import 'package:google_maps_cluster_manager_2/google_maps_cluster_manager_2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place extends ClusterItem {
  final String name;
  final bool isClosed;
  final LatLng latLng;

  Place({required this.name, required this.latLng, this.isClosed = false}) : super(name, latLng);

  @override
  String toString() {
    return 'Place $name (closed : $isClosed)';
  }
}
