import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:taccicle/data/datasource/storage.dart';
import 'package:taccicle/domain/entities/User.dart';
import 'package:taccicle/domain/user_cases/auth_user_cases.dart';

class AuthProvider extends ChangeNotifier {

  User? user;
  String? token;
  bool authenticated = false;



  setUser(User user){
    this.user = user;
    token = Storage.prefs.getString(Storage.TOKEN);
    authenticated = true;
    notifyListeners();
  }

  Future<User?> checkAuth() async {
    
    User? user = await authUserCases.checkCurrentToken();

    if(user == null) return null;
    
    setUser(user);
  
    return user;
  }

  logoutUser(){
    user = null;
    authenticated = false;
    notifyListeners();
  }



}