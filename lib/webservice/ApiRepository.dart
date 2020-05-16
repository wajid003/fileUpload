import 'dart:async';

import 'package:dio/dio.dart';
import 'package:fileupload/model/ErrorResponse.dart';
import 'package:fileupload/model/base_response.dart';
import 'package:fileupload/provider/base_provider.dart';
import 'package:fileupload/webservice/api_endpoint.dart';
import 'package:flutter/cupertino.dart';

import 'ApiClient.dart';

class ApiRepository {
  static final Dio _dio = ApiClient().getDio();
  StreamController _streamController = StreamController.broadcast();
  static BaseProvider _baseProvider;

  ApiRepository() {
//    _baseProvider = baseProvider;
  }

  void _enqueue(Response response) {
    if (response.data != null && response.statusCode == 200) {
      _streamController.sink.add(response);
    } else if (response.statusCode == 401) {
      /**Perform unauthorize operation**/
      _baseProvider.performUnauthorize();
    } else if (response.statusCode == 202) {
      _streamController.sink.addError(ErrorResponse(
          errorMessage: (response as BaseResponse).message,
          statusCode: response.statusCode));
    } else {
      _streamController.sink.addError(ErrorResponse(
          errorMessage: "Something went wrong",
          statusCode: response.statusCode));
    }
    _closeStream();
  }

  void _closeStream() {
    _streamController.close();
  }

  Stream _getStreamController() {
    _streamController = StreamController();
    return _streamController.stream;
  }

  Stream<dynamic> _perFormApi(Future<Response> apiCall) {
    apiCall.then((response) {
      _enqueue(response);
    }, onError: (error) {
      _enqueue((error as DioError).response);
    });
    return _getStreamController();
  }

  Future<Response> uploadFile(FormData formData, Function(dynamic file) callback) async{
    return  _dio.post(ApiEndPoint.chat, data: formData, onSendProgress: (int sent,int total){
      print("api progress===");
      callback({
        "progress" : (sent/total)
      });
    });
  }
}
