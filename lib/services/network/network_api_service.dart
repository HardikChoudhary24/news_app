import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:junglee_news/services/network/network_exceptions.dart';
import 'package:junglee_news/services/network/base_api_service.dart';

import '../../config/config.dart';

class NetworkApiService implements BaseApiService {
  static final String _apiKey = Config.getApiKey();
  @override
  Future<dynamic> getApiResponse(String Url) async {
    try {
      http.Response response =
          await http.get(Uri.parse(Url), headers: {"x-rapidapi-key": _apiKey});
      return parseResponse(response);
    } on SocketException {
      throw Exceptions(NetworkException.noInternetException);
    } on TimeoutException {
      throw Exceptions(NetworkException.networkTimeoutException);
    }
  }

  @override
  Future postApiResponse(String Url, data) async {
    try {
      http.Response response = await http.post(Uri.parse(Url),
          body: data,
          headers: {"x-rapidapi-key": _apiKey}).timeout(Duration(seconds: 30));
      return parseResponse(response);
    } on SocketException {
      throw Exceptions(NetworkException.noInternetException);
    } on TimeoutException {
      throw Exceptions(NetworkException.networkTimeoutException);
    }
  }

  dynamic parseResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        final data = jsonDecode(response.body);
        return data;
      case 400:
        throw Exceptions(NetworkException.badRequestException);
      case 401:
        throw Exceptions(NetworkException.unauthorisedException);
      case 500:
        throw Exceptions(NetworkException.internalServerException);
      default:
        throw Exceptions(NetworkException.generalException);
    }
  }

  Future<dynamic> loadLocalJson() async {
    final String response =
        await rootBundle.loadString('assets/data/data.json');
    final data = jsonDecode(response);
    return data;
  }
}
