import 'dart:convert';

List<LocationResponseModel> locationResponseModelFromJson(String str) => List<LocationResponseModel>.from(json.decode(str).map((x) => LocationResponseModel.fromJson(x)));

String locationResponseModelToJson(List<LocationResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LocationResponseModel {
  final String id;
  final String name;
  final String? parentId;

  LocationResponseModel({
    required this.id,
    required this.name,
    required this.parentId,
  });

  factory LocationResponseModel.fromJson(Map<String, dynamic> json) => LocationResponseModel(
    id: json["id"],
    name: json["name"],
    parentId: json["parentId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "parentId": parentId,
  };
}
