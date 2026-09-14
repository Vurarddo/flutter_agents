import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_agents/domain/example/entities/example_item.dart';
import 'package:flutter_agents/domain/example/repositories/i_example_repository.dart';
import 'package:flutter_agents/domain/example/usecases/get_example_items_usecase.dart';

class MockExampleRepository extends Mock implements IExampleRepository {}

void main() {
  late MockExampleRepository mockRepository;
  late GetExampleItemsUseCase useCase;

  setUp(() {
    mockRepository = MockExampleRepository();
    useCase = GetExampleItemsUseCase(mockRepository);
  });

  test('should return list of example items from repository', () async {
    const tItems = [
      ExampleItem(
        id: '1',
        title: 'Item 1',
        description: 'Description 1',
        isActive: true,
      ),
    ];

    when(() => mockRepository.getExampleItems()).thenAnswer((_) async => tItems);

    final result = await useCase();

    expect(result, tItems);
    verify(() => mockRepository.getExampleItems()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
