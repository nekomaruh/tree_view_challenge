import '../../data/model/asset_response_model.dart';
import '../entity/asset.dart';
import '../enum/sensor_type.dart';
import '../enum/status.dart';

extension AssetResponseMapper on AssetResponseModel {
  Asset toDomain() {
    return Asset(
      id,
      locationId: locationId,
      name: name,
      parentId: parentId,
      gatewayId: gatewayId,
      sensorId: sensorId,
      sensorType: sensorTypeValues.map[sensorType],
      status: statusValues.map[status],
    );
  }
}

extension AssetModelListMapper on List<AssetResponseModel> {
  List<Asset> toDomainList() {
    return map((model) => model.toDomain()).toList();
  }
}
