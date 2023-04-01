import 'package:dio/dio.dart';
import 'package:taccicle/data/datasource/storage.dart';
import 'package:taccicle/data/models/AuthResponse.dart';
import 'package:taccicle/domain/entities/User.dart';
import 'package:taccicle/domain/excepcions/existent_user.dart';
import 'package:taccicle/domain/excepcions/invalid_user.dart';
import 'package:taccicle/data/datasource/backend_api.dart';

class AuthService {
  
  static Future<User?> login(String username, String password) async {
    try {
      
      final response = await BackendApi.httpPost('/auth/signin', {'username': username, 'password': password});

      final authResp = AuthResponses.fromJson(response);
      
      await Storage.prefs.setString(Storage.TOKEN, authResp.token);
      
      BackendApi.configureDio();

      return authResp.user;

    } on DioError catch (err) {
      if (err.response?.statusCode == 401) {
        throw InvalidUser();
      }
    }
    
    return null;

  }

  static Future<User?> register(String username, String password, Map img) async {
    try {
      
      
      final response = await BackendApi.httpPost('/auth/register', {'username': username, 'password': password, "avatar":img.containsKey('folder') ? img['folder'] : null });
      
      final authResp = AuthResponses.fromJson(response);

      if(!img.containsKey('folder')){
        final response = await BackendApi.uploadFile("/user/uploadAvatar/${authResp.user.idUser}",img['bytes']);
        authResp.user.avatar = response['avatar'];
      }

      await Storage.prefs.setString(Storage.TOKEN, authResp.token);
      
      BackendApi.configureDio();

      return authResp.user;
      
    } on DioError catch (err) {
      if (err.response?.statusCode == 409) {
        throw ExistentUser();
      }
    }

    return null;
  }


  static Future<User?> checkToken() async {

    String? token = Storage.prefs.getString("TOKEN");

    if(token == null) return null;

    try{

      final response = await BackendApi.httpGet('/auth/verify');
      
      final authResp = AuthResponses.fromJson(response);
      
      await Storage.prefs.setString(Storage.TOKEN, authResp.token);
      
      BackendApi.configureDio();

      return authResp.user;

    }on DioError catch (err) {
      return null;
    }
    

  }

  static Future<bool> logout() async {
    return Storage.prefs.remove(Storage.TOKEN);
  }
} 

 