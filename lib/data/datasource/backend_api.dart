import 'dart:io';

import 'package:dio/dio.dart';
import 'package:taccicle/data/datasource/storage.dart';

class BackendApi {

  static Dio _dio = Dio();

  static void configureDio(){
    
    String baseUrl = false ? '10.0.2.2:3000' : '86f1-181-29-112-207.sa.ngrok.io'; 
    _dio.options.baseUrl = 'https://$baseUrl/api';

    _dio.options.headers = {
      'x-token': Storage.prefs.getString(Storage.TOKEN) ?? ''
    };
  }



  static Future httpGet(String path) async {

    final resp = await _dio.get(path);

    return resp.data;

  }

  static Future httpPost(String path, Map<String, dynamic> body) async {
       
    final resp = await _dio.post(path, data: body );
    
    return resp.data;        

  }

}