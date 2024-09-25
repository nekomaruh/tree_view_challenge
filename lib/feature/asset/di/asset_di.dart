import 'package:tree_view_challenge/feature/asset/data/repository/asset_repository_impl.dart';
import 'package:tree_view_challenge/feature/asset/domain/repository/asset_repository.dart';
import 'package:tree_view_challenge/feature/asset/domain/use_case/get_assets_use_case.dart';
import 'package:tree_view_challenge/feature/asset/domain/use_case/get_locations_use_case.dart';

import '../../../core/di/get_it.dart';

setupAssetFeature() {
  sl.registerLazySingleton<AssetRepository>(
    () => AssetRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<GetLocationsUseCase>(
        () => GetLocationsUseCase(sl()),
  );

  sl.registerLazySingleton<GetAssetsUseCase>(
        () => GetAssetsUseCase(sl()),
  );
}