import 'package:tree_view_challenge/feature/asset/domain/tree/base_node.dart';

import '../entity/asset.dart';

class AssetNode extends BaseNode<Asset> {
  AssetNode({
    required super.data,
    super.children = const [],
  });
}