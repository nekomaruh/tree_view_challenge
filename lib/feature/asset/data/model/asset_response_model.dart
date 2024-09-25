import 'dart:convert';

List<AssetResponseModel> assetResponseModelFromJson(String str) => List<AssetResponseModel>.from(json.decode(str).map((x) => AssetResponseModel.fromJson(x)));

String assetResponseModelToJson(List<AssetResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AssetResponseModel {
  final String? gatewayId;
  final String id;
  final String locationId;
  final String name;
  final String? parentId;
  final String sensorId;
  final String? sensorType;
  final String status;

  AssetResponseModel({
    required this.gatewayId,
    required this.id,
    required this.locationId,
    required this.name,
    required this.parentId,
    required this.sensorId,
    required this.sensorType,
    required this.status,
  });

  factory AssetResponseModel.fromJson(Map<String, dynamic> json) => AssetResponseModel(
    gatewayId: json["gatewayId"],
    id: json["id"],
    locationId: json["locationId"],
    name: json["name"],
    parentId: json["parentId"],
    sensorId: json["sensorId"],
    sensorType: json["sensorType"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "gatewayId": gatewayId,
    "id": id,
    "locationId": locationId,
    "name": name,
    "parentId": parentId,
    "sensorId": sensorId,
    "sensorType": sensorType,
    "status": status,
  };
}


// sensorTypeValues.map[json["sensorType"]]
//statusValues.reverse[status]