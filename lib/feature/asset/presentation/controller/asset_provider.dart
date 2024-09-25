import 'package:flutter/widgets.dart';
import 'package:tree_view_challenge/core/state/ui_state.dart';
import 'package:tree_view_challenge/feature/asset/domain/tree/node.dart';
import 'package:tree_view_challenge/feature/asset/domain/tree/data_tree.dart';
import 'package:tree_view_challenge/feature/asset/domain/use_case/get_assets_use_case.dart';
import 'package:tree_view_challenge/feature/asset/domain/use_case/get_locations_use_case.dart';

class AssetProvider with ChangeNotifier {
  final GetLocationsUseCase getLocations;
  final GetAssetsUseCase getAssets;

  UiState<DataTree> _state = UiState.init();

  AssetProvider(this.getLocations, this.getAssets);

  UiState<DataTree> get state => _state;

  fetchData(String companyId) async {
    _state = _state.copyWith(isLoading: true, data: DataTree());
    //await Future.delayed(const Duration(milliseconds: 1000));
    await fetchLocations(companyId);
    await fetchAssets(companyId);
    notifyListeners();
  }

  fetchLocations(String companyId) async {
    try {
      final params = GetLocationParams(companyId);
      var locations = await getLocations(params);
      final tree = DataTree();
      print("DATA SIZE: ${locations.length}");
      for (int i = 0; i < locations.length; i++) {
        if (tree.insertRootLocation(locations[i])) {
          locations.removeAt(i);
          i--;
        }
      }
      print("LOCATION PARENTS INSERTED");

      for (int i = 0; i < locations.length; i++) {
        if (tree.insertChildLocation(locations[i])) {
          locations.removeAt(i);
          i--;
        }
      }
      print("LOCATION CHILDREN INSERTED");
      _state = _state.copyWith(data: tree, isLoading: false);
      //notifyListeners();
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      //notifyListeners();
    }
  }

  fetchAssets(String companyId) async {
    try {
      final params = GetAssetParams(companyId);
      var assets = await getAssets(params);
      print("ASSETS LOADED");
      final tree = _state.data!;
      print("DATA SIZE: ${assets.length}");
      for (int i = 0; i < assets.length; i++) {
        if (tree.insertRootAsset(assets[i])) {
          assets.removeAt(i);
          i--;
        }
      }
      print("ASSET PARENTS INSERTED");
      for (int i = 0; i < assets.length; i++) {
        if (tree.insertChildAssetToLocation(assets[i])) {
          assets.removeAt(i);
          i--;
        }
      }

      for (int i = 0; i < assets.length; i++) {
        if (tree.insertChildAssetToParent(assets[i])) {
          assets.removeAt(i);
          i--;
        }
      }
      print("LOCATION CHILDREN INSERTED");
      print("Remaining nodes: ${assets.length}");
      _state = _state.copyWith(data: tree, isLoading: false);
      //notifyListeners();
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
     // notifyListeners();
    }
  }
}
