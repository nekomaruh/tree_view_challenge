import 'package:flutter/cupertino.dart';
import 'package:tree_view_challenge/feature/asset/domain/entity/location.dart';
import 'package:tree_view_challenge/feature/asset/domain/tree/node.dart';

import '../entity/asset.dart';
import '../entity/data.dart';

class DataTree {
  final Node _root = Node(children: []);
  int _nodes = 0;

  DataTree() {
    _root.parent = _root;
  }

  bool _insertNode(Data data, Node parent){
    final node = Node(data: data, children: []);
    parent.children.add(node);
    node.parent = parent;
    _nodes++;
    return true;
  }

  bool insertRootLocation(Location location) {
    if (location.parentId != null) return false;
    debugPrint("Insert L: ${location.id}");
    return _insertNode(location, _root);
  }

  bool insertRootAsset(Asset asset) {
    if (asset.parentId != null || asset.locationId != null) return false;
    return _insertNode(asset, _root);
  }

  bool insertChildLocation(Location location) {
    if (location.parentId == null) return false;
    Node? parent = _findParent(_root, location.parentId);
    if (parent != null) {
      debugPrint("Insert child: ${parent.data!.id}");
      return _insertNode(location, parent);
    } else {
      debugPrint('Parent with id ${location.parentId} not found.');
      return false;
    }
  }

  bool insertChildAssetToLocation(Asset asset) {
    if (asset.locationId == null) return false;
    Node? parent = _findParent(_root, asset.locationId);
    if (parent != null) {
      debugPrint("Insert child: ${parent.data!.id}");
      return _insertNode(asset, parent);
    } else {
      debugPrint('Parent with id ${asset.parentId} not found.');
      return false;
    }
  }

  bool insertChildAssetToParent(Asset asset) {
    if (asset.parentId == null) return false;
    Node? parent = _findParent(_root, asset.locationId);
    if (parent != null) {
      debugPrint("Insert child: ${parent.data!.id}");
      return _insertNode(asset, parent);
    } else {
      debugPrint('Parent with id ${asset.parentId} not found.');
      return false;
    }
  }

  Node? _findParent<T>(Node<T> node, String? id){
    if (node.data?.id == id) return node;
    for (var child in node.children) {
      Node? found = _findParent(child, id);
      if (found != null) return found;
    }
    return null;
  }

  Node<Location>? _findParentLocation(Node node, String? id) {
    if (node.data is Location && node.data?.id == id) {
      return node as Node<Location>;
    }
    for (var child in node.children) {
      Node<Location>? found = _findParentLocation(child, id);
      if (found != null) return found;
    }
    return null;
  }


  Node get root => _root;

  int get nodes => _nodes;
}
