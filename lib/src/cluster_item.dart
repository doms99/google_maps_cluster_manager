import 'package:flutter/widgets.dart';
import 'package:google_maps_cluster_manager_2/google_maps_cluster_manager_2.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart' hide ClusterManager;

@immutable
abstract class ClusterItem {
  ClusterItem(
    this.id,
    this.location, [
    String? geohash,
  ]) : geohash = geohash ??
            Geohash.encode(
              latLng: location,
              codeLength: ClusterManager.precision,
            );

  factory ClusterItem.fromJson(Map<String, dynamic> json) {
    return BasicClusterItem(
      json['id'] as String,
      LatLng.fromJson(json['location'])!,
      json['geohash'] as String,
    );
  }

  final String id;
  final LatLng location;
  final String geohash;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'location': location.toJson(),
      'geohash': geohash,
    };
  }
}

final class BasicClusterItem extends ClusterItem {
  BasicClusterItem(
    super.id,
    super.location, [
    super.geohash,
  ]);
}
