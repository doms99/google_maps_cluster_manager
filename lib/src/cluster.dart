// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/foundation.dart';
import 'package:google_maps_cluster_manager_2/google_maps_cluster_manager_2.dart';
import 'package:google_maps_cluster_manager_2/src/cluster_item.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

@immutable
class Cluster<T extends ClusterItem> {
  const Cluster(this.items, this.location);

  Cluster.fromItems(this.items)
      : location = LatLng(
          items.fold<double>(0, (p, c) => p + c.location.latitude) / items.length,
          items.fold<double>(0, (p, c) => p + c.location.longitude) / items.length,
        );

  //location becomes weighted avarage lat lon
  Cluster.fromClusters(Cluster<T> cluster1, Cluster<T> cluster2)
      : items = cluster1.items.toSet()..addAll(cluster2.items.toSet()),
        location = LatLng(
          (cluster1.location.latitude * cluster1.count + cluster2.location.latitude * cluster2.count) /
              (cluster1.count + cluster2.count),
          (cluster1.location.longitude * cluster1.count + cluster2.location.longitude * cluster2.count) /
              (cluster1.count + cluster2.count),
        );

  static Cluster<ClusterItem> fromJson(Map<String, dynamic> json) {
    return Cluster(
      (json['items'] as List<dynamic>).map((e) => ClusterItem.fromJson(e as Map<String, dynamic>)).toList(),
      LatLng.fromJson(json['location'])!,
    );
  }

  final LatLng location;
  final Iterable<T> items;

  /// Get number of clustered items
  int get count => items.length;

  /// True if cluster is not a single item cluster
  bool get isMultiple => items.length > 1;

  /// Basic cluster marker id
  String getId() {
    return '${location.latitude}_${location.longitude}_$count';
  }

  @override
  String toString() {
    return 'Cluster of $count $T (${location.latitude}, ${location.longitude})';
  }

  @override
  bool operator ==(Object other) => other is Cluster && items == other.items;

  @override
  int get hashCode => items.hashCode;

  Map<String, dynamic> toJson() {
    return {
      'location': location.toJson(),
      'items': items.map((e) => e.toJson()).toList(),
    };
  }
}
