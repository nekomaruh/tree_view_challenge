import 'node.dart';

class FlatNode {
  final Node node;
  final int depth;
  bool isExpanded;

  FlatNode({
    required this.node,
    required this.depth,
    this.isExpanded = false,
  });
}
