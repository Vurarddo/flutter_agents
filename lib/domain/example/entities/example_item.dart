import 'package:freezed_annotation/freezed_annotation.dart';

part 'example_item.freezed.dart';

@freezed
class ExampleItem with _$ExampleItem {
  final String id;
  final String title;
  final String description;
  final bool isActive;

  const ExampleItem({
    required this.id,
    required this.title,
    required this.description,
    required this.isActive,
  });
}
