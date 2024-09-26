import 'package:tree_view_challenge/feature/asset/domain/entity/asset.dart';

import '../../../../core/usecase/use_case.dart';
import '../repository/asset_repository.dart';

class GetAssetParams {
  final String companyId;

  GetAssetParams(this.companyId);
}

class GetAssetsUseCase implements UseCase<GetAssetParams, List<Asset>> {
  final AssetRepository repository;

  GetAssetsUseCase(this.repository);

  @override
  Future<List<Asset>> call(GetAssetParams params) async {
    return await repository.getAssets(companyId: params.companyId);
  }
}
