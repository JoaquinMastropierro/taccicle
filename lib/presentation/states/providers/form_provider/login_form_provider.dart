import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taccicle/data/repositories/auth_service.dart';
import 'package:taccicle/domain/entities/User.dart';
import 'package:taccicle/domain/excepcions/invalid_user.dart';
import 'package:taccicle/domain/user_cases/auth_user_cases.dart';
import 'package:taccicle/presentation/states/providers/auth_provider.dart';
import 'package:taccicle/presentation/services/toast_service.dart';

class LoginFormProvider extends ChangeNotifier {
  final AuthProvider _authProvider;
  String? username = '';
  String? password = '';

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  LoginFormProvider(this._authProvider);

  login(context) async {
        
    try{

      if(!formkey.currentState!.validate()) throw InvalidUser();

      User? user = await authUserCases.login(username!, password!);
      
      _authProvider.setUser(user!);
      
    } on InvalidUser catch(e){      
        ToastService.error(e.getMessage());
    }
  
  }

}