import 'package:json_annotation/json_annotation.dart';

import 'package:flutter_agents/domain/example/entities/example_item.dart';

part 'example_item_dto.g.dart';

@JsonSerializable()
class ExampleItemDto {
  final String id;
  final String title;
  final String description;
  @JsonKey(name: 'is_active', defaultValue: true)
  final bool isActive;

  const ExampleItemDto({
    required this.id,
    required this.title,
    required this.description,
    required this.isActive,
  });

  factory ExampleItemDto.fromJson(Map<String, dynamic> json) => _$ExampleItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ExampleItemDtoToJson(this);

  ExampleItem toDomain() => ExampleItem(
    id: id,
    title: title,
    description: description,
    isActive: isActive,
  );
}
