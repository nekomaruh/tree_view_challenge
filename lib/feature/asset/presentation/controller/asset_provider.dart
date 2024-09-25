import 'package:flutter/widgets.dart';
import 'package:tree_view_challenge/core/state/ui_state.dart';
import 'package:tree_view_challenge/feature/asset/domain/tree/base_node.dart';
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
    await Future.delayed(const Duration(seconds: 1));
    await fetchLocations(companyId);
    await fetchAssets();
  }

  fetchLocations(String companyId) async {
    try {
      final params = GetLocationParams(companyId);
      var locations = await getLocations(params);
      final tree = _state.data;
      print("DATA SIZE: ${locations.length}");
      Stopwatch stopwatch = Stopwatch()..start();

      /*
      for (final location in locations) {
        tree?.insertParentLocation(location);
      }*/

      for (int i = 0; i < locations.length; i++) {
        tree?.insertParentLocation(locations[i]);
        locations.removeAt(i);
        i--;
      }
      print("PARENTS INSERTED");
      for (final location in locations) {
        tree?.insertChildLocation(location);
      }
      print('Function executed in ${stopwatch.elapsed * 1000}');
      print("CHILDREN INSERTED");
      _state = _state.copyWith(data: tree, isLoading: false);
      notifyListeners();
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      notifyListeners();
    }
  }

  fetchAssets() {}
}
