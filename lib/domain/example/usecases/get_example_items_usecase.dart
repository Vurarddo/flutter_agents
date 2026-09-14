import 'package:injectable/injectable.dart';

import 'package:flutter_agents/domain/example/entities/example_item.dart';
import 'package:flutter_agents/domain/example/repositories/i_example_repository.dart';

@injectable
class GetExampleItemsUseCase {
  final IExampleRepository _repository;

  const GetExampleItemsUseCase(this._repository);

  Future<List<ExampleItem>> call() {
    return _repository.getExampleItems();
  }
}
