import 'package:flutter_agents/domain/example/entities/example_item.dart';

abstract interface class IExampleRepository {
  Future<List<ExampleItem>> getExampleItems();
}
