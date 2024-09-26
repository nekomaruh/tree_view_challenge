import 'package:tree_view_challenge/feature/asset/domain/entity/location.dart';
import 'package:tree_view_challenge/feature/asset/domain/tree/node.dart';

import '../entity/asset.dart';
import '../entity/data.dart';
import 'flat_node.dart';

class DataTree {
  final Node _root = Node(children: []);
  int _nodes = 0;

  DataTree() {
    _root.parent = _root;
  }

  bool _insertNode(Data data, Node parent) {
    final node = Node(data: data, children: []);
    parent.children.add(node);
    node.parent = parent;
    _nodes++;
    return true;
  }

  bool insertRootLocation(Location location) {
    if (location.parentId != null) return false;
    return _insertNode(location, _root);
  }

  bool insertRootAsset(Asset asset) {
    if (asset.parentId != null || asset.locationId != null) return false;
    return _insertNode(asset, _root);
  }

  bool insertChildLocation(Location location) {
    if (location.parentId == null) return false;
    Node? parent = _findParent(_root, location.parentId);
    if(parent == null) return false;
    return _insertNode(location, parent);
  }

  bool insertChildAssetToLocation(Asset asset) {
    if (asset.locationId == null) return false;
    Node? parent = _findParent(_root, asset.locationId);
    if(parent == null) return false;
    return _insertNode(asset, parent);
  }

  bool insertChildAssetToParent(Asset asset) {
    if (asset.parentId == null) return false;
    Node? parent = _findParent(_root, asset.parentId);
    if(parent == null) return false;
    return _insertNode(asset, parent);
  }

  Node? _findParent<T>(Node<T> node, String? id) {
    if (node.data?.id == id) return node;
    for (var child in node.children) {
      Node? found = _findParent(child, id);
      if (found != null) return found;
    }
    return null;
  }

  Node get root => _root;

  int get nodes => _nodes;

  List<T> insertNode<T>(List<T> nodes, Function insertFunction) {
    List<T> remainingNodes = [];

    for (var node in nodes) {
      if (!insertFunction(node)) {
        remainingNodes.add(node);
      }
    }

    nodes.clear();
    nodes.addAll(remainingNodes);
    return remainingNodes;
  }

  List<FlatNode> toFlatTree() => _toFlatTree(_root);

  List<FlatNode> _toFlatTree(Node node, [int deph = 0]) {
    List<FlatNode> result = [
      FlatNode(
        node: node,
        depth: deph,
        isExpanded: node.children.isNotEmpty,
      )
    ];
    if (node.children.isNotEmpty) {
      for (var child in node.children) {
        result.addAll(_toFlatTree(child, deph + 1));
      }
    }
    return result;
  }
}
