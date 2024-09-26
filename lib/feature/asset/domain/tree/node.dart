import '../entity/data.dart';

class Node<T> {
  Data? data;
  List<Node> children;
  Node? parent;

  Node({
    this.data,
    required this.children,
  });
}
