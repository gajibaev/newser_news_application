// ignore_for_file: file_names
import 'dart:async';

import 'package:news_repository/news_repository.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'RestClient.g.dart';

@RestApi(
  baseUrl: "https://api.nytimes.com/svc/news/v3/content",
  parser: Parser.JsonSerializable,
)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/{source}/{section}")
  Future<ArticleResponse> getArticles(@Path("source") String source,
      @Path("section") String section, @Query("api-key") String key);

  @GET("/section-list.json?api-key=[Your Api Key]")
  Future<SectionResponse> getSections(String key);
}
