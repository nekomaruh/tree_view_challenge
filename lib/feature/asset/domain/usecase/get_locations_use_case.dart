import 'package:tree_view_challenge/feature/asset/domain/entity/location.dart';
import 'package:tree_view_challenge/feature/asset/domain/repository/asset_repository.dart';

import '../../../../core/usecase/use_case.dart';

class GetLocationParams {
  final String companyId;

  GetLocationParams(this.companyId);
}

class GetLocationsUseCase implements UseCase<GetLocationParams, List<Location>> {
  final AssetRepository repository;

  GetLocationsUseCase(this.repository);

  @override
  Future<List<Location>> call(GetLocationParams params) async {
    return await repository.getLocations(companyId: params.companyId);
  }
}
