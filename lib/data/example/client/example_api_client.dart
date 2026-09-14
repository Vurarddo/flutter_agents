import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import 'package:flutter_agents/data/example/dto/example_item_dto.dart';
import 'package:flutter_agents/data/example/endpoints/example_endpoints.dart';

part 'example_api_client.g.dart';

@lazySingleton
@RestApi()
abstract class ExampleApiClient {
  @factoryMethod
  factory ExampleApiClient(Dio dio) = _ExampleApiClient;

  @GET(ExampleEndpoints.items)
  Future<List<ExampleItemDto>> getExampleItems();
}
