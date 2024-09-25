import 'package:flutter/widgets.dart';
import 'package:tree_view_challenge/feature/asset/domain/use_case/get_assets_use_case.dart';
import 'package:tree_view_challenge/feature/asset/domain/use_case/get_locations_use_case.dart';

class AssetProvider with ChangeNotifier {
  final GetAssetsUseCase getAssets;
  final GetLocationsUseCase getLocations;

  AssetProvider(this.getAssets, this.getLocations);
}