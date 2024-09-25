import 'data.dart';

class Location extends Data {
  final String name;
  final String? parentId;

  Location(
    super.id, {
    required this.name,
    this.parentId,
  });
}
