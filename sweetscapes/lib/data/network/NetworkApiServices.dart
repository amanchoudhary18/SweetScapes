import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:sweetscapes/data/app_exceptions.dart';
import 'package:sweetscapes/data/network/BaseApiServices.dart';
import 'package:http/http.dart' as http;

import '../../model/user_model.dart';
import '../../view_model/user_view_model.dart';

class NetworkApiServices extends BaseApiServices {
  String? getToken() {
    UserViewModel().getUser().then((value) {
      return value.token.toString();
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
      return '';
    });
  }

  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 5));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      http.Response response = await http
          .post(
            Uri.parse(url), 
            body: data
            )
          .timeout(const Duration(seconds: 5));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future userPutApiResponse(String url, dynamic data, String token) async {
    dynamic responseJson;
    final msg = jsonEncode(data);
    try {
      http.Response response = await http
          .put(
            Uri.parse(url),
            body: msg,
            headers: {
              'Content-type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            encoding: Encoding.getByName("utf-8"),
          )
          .timeout(const Duration(seconds: 5));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future userPostApiResponse(String url, dynamic data, String token) async {
    dynamic responseJson;
    final msg = jsonEncode(data);
    try {
      http.Response response = await http
          .post(
            Uri.parse(url),
            body: msg,
            headers: {
              'Content-type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            encoding: Encoding.getByName("utf-8"),
          )
          .timeout(const Duration(seconds: 5));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future userGetApiResponse(String url, String token) async {
    dynamic responseJson;
    try {
      http.Response response = await http
          .get(
            Uri.parse(url),
            headers: {
              'Content-type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            // encoding: Encoding.getByName("utf-8"),
          )
          .timeout(const Duration(seconds: 5));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 400:
        throw BadRequestException(
            'Bad Request Exception, status: ${response.statusCode}');
      case 401:
        throw UnauthorizedException(
            'Unauthorized Exception, status: ${response.statusCode}');
      default:
        throw FetchDataException(
            'Error occured with status code: ${response.statusCode}');
    }
  }

}
