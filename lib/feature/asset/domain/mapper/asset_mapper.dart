import '../../data/model/asset_response_model.dart';
import '../entity/asset.dart';
import '../enum/sensor_type.dart';
import '../enum/status.dart';

extension AssetResponseMapper on AssetResponseModel {
  Asset toDomain() {
    return Asset(
      id: id,
      locationId: locationId,
      name: name,
      parentId: parentId,
      gatewayId: gatewayId,
      sensorId: sensorId,
      sensorType: sensorType != null ? sensorTypeValues.map[sensorType] : null,
      status: status != null ? statusValues.map[status] : null,
    );
  }
}