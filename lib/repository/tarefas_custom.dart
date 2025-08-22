import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lista_tarefas/repository/tarefas_interceptor.dart';

class TarefasCustom {
  final _dio = Dio();

  Dio get dio => _dio;

  TarefasCustom() {
    _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.baseUrl = dotenv.get("URLBASE");
    _dio.interceptors.add(TarefasInterceptor());
  }
}
