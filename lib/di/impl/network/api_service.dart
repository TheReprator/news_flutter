import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';
import 'package:news_flutter/data/repository/remote/entity/entity_news.dart';

part 'api_service.chopper.dart';

@ChopperApi()
abstract class ApiService extends ChopperService {
  @Get(path: 'v2/top-headlines')
  Future<List<EntityNews>> getHeadLines(
    @Query("category") String sources,
    @Query("page") int page,
    @Query("pageSize") int pageSize,
  );

  @factoryMethod
  static ApiService create(ChopperClient client) {
    return _$ApiService(client);
  }
}
