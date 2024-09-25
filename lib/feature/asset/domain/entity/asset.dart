import 'package:tree_view_challenge/feature/asset/domain/enum/sensor_type.dart';
import 'package:tree_view_challenge/feature/asset/domain/enum/status.dart';

class Asset {
  final String id;
  final String locationId;
  final String name;
  final String? parentId;
  final String? gatewayId;
  final String sensorId;
  final SensorType? sensorType;
  final Status? status;

  Asset({
    required this.id,
    required this.locationId,
    required this.name,
    this.parentId,
    required this.gatewayId,
    required this.sensorId,
    this.sensorType,
    this.status,
  });
}
