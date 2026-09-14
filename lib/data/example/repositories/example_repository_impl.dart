import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_agents/data/example/client/example_api_client.dart';
import 'package:flutter_agents/domain/example/entities/example_item.dart';
import 'package:flutter_agents/domain/example/failures/example_failure.dart';
import 'package:flutter_agents/domain/example/repositories/i_example_repository.dart';

@LazySingleton(as: IExampleRepository)
class ExampleRepositoryImpl implements IExampleRepository {
  final ExampleApiClient _apiClient;

  const ExampleRepositoryImpl(this._apiClient);

  @override
  Future<List<ExampleItem>> getExampleItems() async {
    try {
      final dtos = await _apiClient.getExampleItems();
      return dtos.map((dto) => dto.toDomain()).toList();
    } on DioException catch (dioError) {
      if (dioError.type == DioExceptionType.connectionTimeout ||
          dioError.type == DioExceptionType.receiveTimeout ||
          dioError.type == DioExceptionType.connectionError) {
        throw const NetworkExampleFailure();
      }
      final statusCode = dioError.response?.statusCode;
      throw ServerExampleFailure(
        message: dioError.message ?? 'Server error',
        statusCode: statusCode,
      );
    } catch (e, st) {
      throw UnknownExampleFailure(error: e, stackTrace: st);
    }
  }
}
