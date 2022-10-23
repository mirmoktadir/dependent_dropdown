import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'app_exceptions.dart';

class DioClient {
  static const int TIME_OUT_DURATION = 20;
  //GET
  Future<dynamic> get(String url, Map<String, dynamic> header) async {
    var uri = Uri.parse(url);

    try {
      var response = await Dio()
          .get(url, options: Options(headers: header))
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  //POST
  Future<dynamic> post(
      String url, Map<String, dynamic> header, dynamic payloadObj) async {
    var uri = Uri.parse(url);
    var payload = json.encode(payloadObj);
    try {
      var response = await Dio()
          .post(url, options: Options(headers: header), data: payload)
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  //PATCH

  Future<dynamic> patch(
      String url, Map<String, dynamic> header, dynamic payloadObj) async {
    var uri = Uri.parse(url);
    var payload = json.encode(payloadObj);
    try {
      var response = await Dio()
          .patch(url, options: Options(headers: header), data: payload)
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  //DELETE
  Future<dynamic> delete(
      String url, Map<String, dynamic> header, dynamic payloadObj) async {
    var uri = Uri.parse(url);
    var payload = json.encode(payloadObj);
    try {
      var response = await Dio()
          .delete(url, options: Options(headers: header), data: payload)
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }
  //OTHER

  dynamic _processResponse(response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;
      case 400:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:
      case 403:
        throw UnAuthorizedException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred with code : ${response.statusCode}',
            response.request!.url.toString());
    }
  }
}
