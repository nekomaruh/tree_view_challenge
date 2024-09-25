import 'package:tree_view_challenge/feature/asset/domain/entity/location.dart';
import 'package:tree_view_challenge/feature/asset/domain/tree/base_node.dart';

import '../entity/asset.dart';
import 'location_node.dart';

class DataTree {
  final BaseNode _root = BaseNode(children: []);
  int _nodes = 0;

  DataTree() {
    _root.parent = _root;
  }

  insertParentLocation(Location location) {
    if (location.parentId != null) return;
    final BaseNode node = LocationNode(data: location, children: []);
    _root.children.add(node);
    node.parent = _root;
    _nodes++;
  }

  insertChildLocation(Location location) {
    if (location.parentId == null) return;
    final node = LocationNode(data: location);

    // Si el parentId es null, lo agregamos directamente al root
    // Buscar el nodo padre
    BaseNode<Location>? parentNode = _findLocationNodeById(
      _root,
      location.parentId,
    );
    if (parentNode != null) {
      // Agregar el nuevo nodo al hijo correspondiente
      parentNode.children.add(node);
      node.parent = parentNode;
      _nodes++;
    } else {
      //print('Parent with id ${location.parentId} not found.');
    }
  }

  BaseNode<Location>? _findLocationNodeById(BaseNode node, String? id) {
    // Si el nodo actual tiene el id que buscamos, lo retornamos
    if (node is LocationNode && node.data?.id == id) {
      return node;
    }
    // Buscamos en los hijos recursivamente
    for (var child in node.children) {
      BaseNode<Location>? found =
          _findLocationNodeById(child as LocationNode, id);
      if (found != null) {
        return found;
      }
    }

    return null; // No se encontró el nodo
  }

  insertAsset(Asset asset) {}

  BaseNode get root => _root;

  int get nodes => _nodes;

}
