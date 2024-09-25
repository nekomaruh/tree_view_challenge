import 'package:tree_view_challenge/feature/asset/domain/entity/location.dart';

import 'base_node.dart';

class LocationNode extends BaseNode<Location> {
  LocationNode({
    required super.data,
    super.children = const [],
  });
}