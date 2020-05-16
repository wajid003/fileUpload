
import 'package:dio/dio.dart';

class ApiClient{
  static final String baseUrl = "http://13.235.147.61/api/";
  static final ApiClient _apiClient = ApiClient._internal();
  Dio _dio;

  ApiClient._internal();

  factory ApiClient() {
    return _apiClient;
  }

  void _init() {
    if (_dio == null) {
      _dio = Dio();
      _dio.options.baseUrl = baseUrl;
      _dio.interceptors.add(LogInterceptor());
      _dio.interceptors.add(InterceptorsWrapper(
          onRequest:(Options options) {
            options.headers["Authorization"] = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjE2ODlkMDc0ODEyNzExNTg0ZDFiNGM1MzgzOTE4YWFmMzNmNjg0OWYyNWUxODdjYWUwNDFlYWEwZjVjYTNhMDIzZTY2N2M4Mzg3ZmIyNzJhIn0.eyJhdWQiOiIxIiwianRpIjoiMTY4OWQwNzQ4MTI3MTE1ODRkMWI0YzUzODM5MThhYWYzM2Y2ODQ5ZjI1ZTE4N2NhZTA0MWVhYTBmNWNhM2EwMjNlNjY3YzgzODdmYjI3MmEiLCJpYXQiOjE1ODQwOTYwNjEsIm5iZiI6MTU4NDA5NjA2MSwiZXhwIjoxNjE1NjMyMDYxLCJzdWIiOiI4NjAiLCJzY29wZXMiOltdfQ.ijSxhwsx0DaF9vAiVMR-ygk4qs9tnMLULMQHZaRDWArEqlM-KdAyyYN_TGSRe_Q9OlzPq1kZWeYTPRTsFDDwcBDuZMD1lGhq5SQzfQADXrW8Y1SpORsSqZUG5QwQ2ICB9OV1l-m_vOmviKfmvAq8bljmzQ6JTUyM7ALLV7VZh8QTgJHEOAaXPVPkBHZft0KAcYwvr3MnHED7Emz0GpgHHOsJrmB4qSIhDJKnTQBsZmPo442OUCWIk2ksyr2IR0v7WtqE-ccDajk3Mh-fD6nEVLlJlv96IWWeWUPktatRTz425hkBoV-nJ3xlt97HDGdusVqZa25rRU7d5pQmV-lpybdViS5ULiT8UnrHAtjItGZK494rye0NDx_2YFvVYpZV_P4-2NGlPxQEnJRgUL1Fm_4h3kCPk4HRNFkdc7qIWz8SC_h-aISR1uY-MCPKPyKqmshFnvWE3YKbh1-7kZsucnMZRjQgP805uaC-yC94CC2wmHpXZLMCXtZIlyo15JkEfi2smLNNOEw0k56Z8-pff6G0yfLG4EsmZu9RxJaatCqx-FtMDlPAtrqq_43KZsHiKg1UwAo1Dq5BhonF3LjJVaUNZekF7yj1U_Cy7jLTklYe21_qZOy1OvsIhHFIbSC87zuRuZj3VypBqb0xIQ6TYhMcPzqqAW5VAQEo-N-rX4U";
            return options;
          }
      ));
      _dio.options.receiveTimeout = 10000;
    }
  }

  Dio getDio() {
    _init();
    return _dio;
  }
}