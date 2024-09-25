import 'package:tree_view_challenge/feature/asset/domain/entity/asset.dart';
import 'package:tree_view_challenge/feature/asset/domain/entity/location.dart';

import '../entity/data.dart';

class Node<T> {
  Data? data;
  List<Node> children;
  Node? parent;

  Node({
    this.data,
    required this.children,
  });

  get id {
    if (data is Location) return (data as Location).id;
    if (data is Asset) return (data as Asset).id;
  }
}
