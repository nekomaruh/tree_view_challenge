class BaseNode<T> {
  T? data;
  List<BaseNode> children;
  BaseNode? parent;

  BaseNode({
    this.data,
    required this.children ,
  });
}
