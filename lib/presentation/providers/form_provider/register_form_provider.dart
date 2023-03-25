import 'package:flutter/material.dart';
import 'package:taccicle/data/repositories/auth_service.dart';
import 'package:taccicle/domain/entities/User.dart';
import 'package:taccicle/domain/excepcions/existent_user.dart';
import 'package:taccicle/domain/excepcions/invalid_user.dart';
import 'package:taccicle/domain/user_cases/auth_user_cases.dart';
import 'package:taccicle/presentation/providers/auth_provider.dart';
import 'package:taccicle/presentation/services/toast_service.dart';

class RegisterFormProvider extends ChangeNotifier {

  final AuthProvider _authProvider;
  String? email = '';
  String? password = '';
  String? repeatedPassword = '';

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  RegisterFormProvider(this._authProvider);

  Future<bool> validateForm() async {
    
    if(!formkey.currentState!.validate()) return false;
    
    try{


      User? user = await authUserCases.register(email!, password!);
      
      _authProvider.setUser(user!);

      return true;
     

    } on ExistentUser catch(e){      
        ToastService.error(e.getMessage());
        return false;
    }


  }

}