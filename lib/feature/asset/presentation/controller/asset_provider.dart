import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:tree_view_challenge/core/state/ui_state.dart';
import 'package:tree_view_challenge/feature/asset/domain/tree/flat_node.dart';
import 'package:tree_view_challenge/feature/asset/domain/tree/data_tree.dart';

import '../../domain/entity/asset.dart';
import '../../domain/entity/location.dart';
import '../../domain/enum/status.dart';
import '../../domain/tree/node.dart';
import '../../domain/usecase/get_assets_use_case.dart';
import '../../domain/usecase/get_locations_use_case.dart';

class AssetProvider with ChangeNotifier {
  final GetLocationsUseCase getLocations;
  final GetAssetsUseCase getAssets;

  bool _filterEnergy = false;
  bool _filterCritical = false;
  String _filterSearch = "";
  List<FlatNode> _filteredData = [];

  UiState<List<FlatNode>> _state = UiState.init();

  AssetProvider(this.getLocations, this.getAssets);

  UiState<List<FlatNode>> get state => _state;

  toggleEnergy(bool value) {
    _filterEnergy = value;
    filterData();
    notifyListeners();
  }

  toggleCritical(bool value) {
    _filterCritical = value;
    filterData();
    notifyListeners();
  }

  updateSearch(String value) {
    _filterSearch = value;
    filterData();
    notifyListeners();
  }

  get isEnergySelected => _filterEnergy;

  get isCriticalSelected => _filterCritical;

  List<FlatNode> get filteredData => _filteredData;

  fetchData(String companyId) async {
    Stopwatch stopwatch = Stopwatch()..start();
    try {
      var tree = DataTree();

      // Get Locations
      final params = GetLocationParams(companyId);
      final locations = await getLocations(params);
      debugPrint("Location Nodes: ${locations.length}");
      tree = await _insertInIsolate(locations, tree, _insertLocations);

      // Get Assets
      final assetParams = GetAssetParams(companyId);
      final assets = await getAssets(assetParams);
      debugPrint("Asset Nodes: ${assets.length}");
      tree = await _insertInIsolate(assets, tree, _insertAssets);

      // Flatten tree
      final flatTree = await _transformTreeInIsolate(tree);
      _state = _state.copyWith(data: flatTree, isLoading: false);
      _filteredData = flatTree;
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    } finally {
      debugPrint('executed in ${stopwatch.elapsed}');
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

  void filterData() {
    if (!_filterEnergy && !_filterCritical && _filterSearch.isEmpty) {
      _filteredData = _state.data!;
      return;
    }

    List<FlatNode> filteredNodes = [];

    for (var node in _state.data!) {
      if (!_filterEnergy && !_filterCritical) {
        if (_findMatchingSearch(node.node)) {
          filteredNodes.add(node);
        }
      }
       if (_findMatchingNodeAndParents(node.node)) {
        if (_filterSearch.isEmpty) {
          filteredNodes.add(node);
        } else if (_findMatchingSearch(node.node)) {
          filteredNodes.add(node);
        }
      }
    }

    _filteredData = filteredNodes;
  }

  bool _findMatchingNodeAndParents(Node node) {
    if (_matchesFilter(node)) return true;
    if (node.children.isNotEmpty) {
      bool hasMatchingChild = false;
      for (var child in node.children) {
        if (_findMatchingNodeAndParents(child)) {
          hasMatchingChild = true;
        }
      }
      return hasMatchingChild;
    }
    return false;
  }

  bool _matchesFilter(Node node) {
    var data = node.data;
    if (data is Asset) {
      return (_filterEnergy && data.status == Status.operating) ||
          (_filterCritical && data.status == Status.alert);
    }
    return false;
  }

  bool _findMatchingSearch(Node node) {
    if (_matchesSearch(node)) return true;

    if (node.children.isNotEmpty) {
      bool hasMatchingChild = false;
      for (var child in node.children) {
        if (_findMatchingSearch(child)) {
          hasMatchingChild = true;
        }
      }
      return hasMatchingChild;
    }
    return false;
  }

  bool _matchesSearch(Node node) {
    if (node.data == null) return false;
    return node.data!.name.toLowerCase().contains(_filterSearch.toLowerCase());
  }
}


