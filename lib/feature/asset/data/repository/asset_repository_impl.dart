import 'package:flutter/cupertino.dart';
import 'package:tree_view_challenge/core/network/api_client.dart';
import 'package:tree_view_challenge/feature/asset/data/model/asset_response_model.dart';
import 'package:tree_view_challenge/feature/asset/domain/entity/asset.dart';
import 'package:tree_view_challenge/feature/asset/domain/entity/location.dart';
import 'package:tree_view_challenge/feature/asset/domain/mapper/asset_mapper.dart';
import 'package:tree_view_challenge/feature/asset/domain/mapper/location_mapper.dart';
import 'package:tree_view_challenge/feature/asset/domain/repository/asset_repository.dart';

import '../model/location_response_model.dart';

class AssetRepositoryImpl implements AssetRepository {
  final ApiClient client;

  AssetRepositoryImpl(this.client);

  @override
  Future<List<Asset>> getAssets({required String companyId}) async {
    final response =
        await client.get("/companies/$companyId/assets") as List<dynamic>;
    final list = response.map((e) => AssetResponseModel.fromJson(e)).toList();
    return list.toDomainList();
  }

  @override
  Future<List<Location>> getLocations({required String companyId}) async {
    final response =
        await client.get("/companies/$companyId/locations") as List<dynamic>;
    final list = response.map((e) => LocationResponseModel.fromJson(e)).toList();
    return list.toDomainList();
  }
}
