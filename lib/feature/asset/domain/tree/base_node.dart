class BaseNode<T> {
  final T data;
  List<BaseNode> children;
  BaseNode? parent;

  BaseNode({
    required this.data,
    required this.children,
  });
}
