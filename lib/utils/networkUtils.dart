import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:flutter_chat_demo/const/valueConstants.dart';

class NetworkUtil {
  // next three lines makes this class a Singleton
  static NetworkUtil _instance = new NetworkUtil.internal();
  NetworkUtil.internal();
  factory NetworkUtil() => _instance;

  final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> get(String path) {
    final String url = '$BASE_URL/$path';
    print(url);
    return http.get(url).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      print(res);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> post(String url, {Map headers, body, encoding}) {
    print(url);
    print(body);
    return http
        .post(BASE_URL + url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      print(res);

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> postWithoutJsonResponse(String url,
      {Map headers, body, encoding}) {
    print(BASE_URL + url);
    print(body);
    return http
        .post(BASE_URL + url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      print(res);

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return res;
    });
  }

  Future<dynamic> uploadPicture(
      String url, String pathToFile, String fileName) async {
    var fileUri = Uri.parse(pathToFile);
    var request =
        new http.MultipartRequest("POST", Uri.parse(BASE_URL+url));
    request.fields['filename'] = fileName;
    var multiPart = new http.MultipartFile.fromBytes(
        'fileToUpload', await File.fromUri(fileUri).readAsBytes(),);
    request.files.add(multiPart);

    

    return request.send().then((response) {
        print(response.statusCode);
      if (response.statusCode == 200) {
        var responseFromStream = http.Response.fromStream(response);
        return responseFromStream.then((responseBody) {
          print(responseBody.toString()+" zdf "+response.request.url.toString());
          // return json.decode(responseBody.body);
        });
      }
    });
  }
}
