import 'dart:convert';

List<CompanyResponseModel> companyFromJson(String str) =>
    List<CompanyResponseModel>.from(
        json.decode(str).map((x) => CompanyResponseModel.fromJson(x)));

String companyToJson(List<CompanyResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CompanyResponseModel {
  final String id;
  final String name;

  CompanyResponseModel({
    required this.id,
    required this.name,
  });

  factory CompanyResponseModel.fromJson(Map<String, dynamic> json) =>
      CompanyResponseModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
