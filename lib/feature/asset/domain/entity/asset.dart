import 'package:tree_view_challenge/feature/asset/domain/entity/data.dart';
import 'package:tree_view_challenge/feature/asset/domain/enum/sensor_type.dart';
import 'package:tree_view_challenge/feature/asset/domain/enum/status.dart';

class Asset extends Data {
  final String? locationId;
  final String name;
  final String? parentId;
  final String? gatewayId;
  final String? sensorId;
  final SensorType? sensorType;
  final Status? status;

  Asset(
    super.id, {
    this.locationId,
    required this.name,
    this.parentId,
    required this.gatewayId,
    required this.sensorId,
    this.sensorType,
    this.status,
  });
}
