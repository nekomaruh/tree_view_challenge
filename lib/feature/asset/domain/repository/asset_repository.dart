import '../entity/asset.dart';
import '../entity/location.dart';

abstract class AssetRepository {
  Future<List<Location>> getLocations({required String companyId});
  Future<List<Asset>> getAssets({required String companyId});
}