import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:taccicle/data/repositories/auth_service.dart';
import 'package:taccicle/domain/entities/User.dart';

class authUserCases {
    

    static Future<User?> login(String username, String password)  async{

      User? user = await AuthService.login(username, _encodePassword(password));
      
      return user;

    }

    static Future<User?> register(String username, String password) async {


      User? user = await  AuthService.register(username, _encodePassword(password));

      return user;
    }

    static String _encodePassword(String password) {

      var bytes = utf8.encode(password);

      Digest hashedPassword = sha256.convert(bytes);

      return hashedPassword.toString();
    }

    static Future<User?> checkCurrentToken()  {

      return AuthService.checkToken();
            
    }

    static Future<bool> logout() async {
      return AuthService.logout();
      

    }
}