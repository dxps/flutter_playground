import 'package:dio/dio.dart';
import 'package:dio_web_adapter/dio_web_adapter.dart';

final Dio httpClient = Dio(
  BaseOptions(
    baseUrl: 'http://localhost:8080',
    contentType: Headers.jsonContentType,
    responseType: ResponseType.json,
  ),
)..httpClientAdapter = (BrowserHttpClientAdapter()..withCredentials = true);
