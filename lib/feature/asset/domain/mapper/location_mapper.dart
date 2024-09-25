import 'package:tree_view_challenge/feature/asset/data/model/location_response_model.dart';
import '../entity/location.dart';

extension LocationResponseMapper on LocationResponseModel {
  Location toDomain() {
    return Location(
      id,
      name: name,
      parentId: parentId,
    );
  }
}

extension LocationModelListMapper on List<LocationResponseModel> {
  List<Location> toDomainList() {
    return map((model) => model.toDomain()).toList();
  }
}