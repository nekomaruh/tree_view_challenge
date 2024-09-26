import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:tree_view_challenge/core/state/ui_state.dart';
import 'package:tree_view_challenge/feature/asset/domain/tree/flat_node.dart';
import 'package:tree_view_challenge/feature/asset/domain/tree/data_tree.dart';
import 'package:tree_view_challenge/feature/asset/domain/use_case/get_assets_use_case.dart';
import 'package:tree_view_challenge/feature/asset/domain/use_case/get_locations_use_case.dart';

import '../../domain/entity/asset.dart';
import '../../domain/entity/location.dart';

class AssetProvider with ChangeNotifier {
  final GetLocationsUseCase getLocations;
  final GetAssetsUseCase getAssets;

  UiState<List<FlatNode>> _state = UiState.init();

  AssetProvider(this.getLocations, this.getAssets);

  UiState<List<FlatNode>> get state => _state;

  fetchData(String companyId) async {
    try {
      var tree = DataTree();

      // Get Locations
      final params = GetLocationParams(companyId);
      final locations = await getLocations(params);
      tree = await _insertInIsolate(locations, tree, _insertLocations);

      // Get Assets
      final assetParams = GetAssetParams(companyId);
      final assets = await getAssets(assetParams);
      tree = await _insertInIsolate(assets, tree, _insertAssets);

      // Flatten tree
      final flatTree = await _transformTreeInIsolate(tree);
      _state = _state.copyWith(data: flatTree, isLoading: false);
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    } finally {
      notifyListeners();
    }
  }

  Future<DataTree> _insertInIsolate(
    List<dynamic> items,
    DataTree tree,
    Function(List<Object>) isolateFunction,
  ) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(isolateFunction, [items, tree, receivePort.sendPort]);
    return await receivePort.first as DataTree;
  }

  Future<List<FlatNode>> _transformTreeInIsolate(DataTree tree) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(_transformTree, [tree, receivePort.sendPort]);
    return await receivePort.first as List<FlatNode>;
  }

  static void _transformTree(List<Object> params) {
    final sendPort = params[1] as SendPort;
    sendPort.send((params[0] as DataTree).toFlatTree());
  }

  static void _insertAssets(List<Object> params) {
    var assets = params[0] as List<Asset>;
    final tree = params[1] as DataTree;
    final sendPort = params[2] as SendPort;

    assets = tree.insertNode(assets, tree.insertChildAssetToLocation);
    assets = tree.insertNode(assets, tree.insertRootAsset);
    do {
      assets = tree.insertNode(assets, tree.insertChildAssetToParent);
    } while (assets.isNotEmpty);

    sendPort.send(tree);
  }

  static void _insertLocations(List<Object> params) {
    var locations = params[0] as List<Location>;
    final tree = params[1] as DataTree;
    final sendPort = params[2] as SendPort;

    locations = tree.insertNode(locations, tree.insertRootLocation);
    do {
      locations = tree.insertNode(locations, tree.insertChildLocation);
    } while (locations.isNotEmpty);

    sendPort.send(tree);
  }
}
