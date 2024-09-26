import 'data.dart';

class Location extends Data {
  final String? parentId;

  Location(
    super.id,
    super.name, {
    this.parentId,
  });
}
