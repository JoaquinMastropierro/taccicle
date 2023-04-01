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
  bool pickedImage = false;
  Map? img;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  RegisterFormProvider(this._authProvider);

  Future<bool> validateForm() async {
    
    
    

      if(!formkey.currentState!.validate()) return false;

  
     
      return true;
  

  }

  void setPickedImg(Map? img){
    this.pickedImage = img != null;
    this.img = img;
    notifyListeners();
  }

  Future register() async{
      
      try{
        User? user = await authUserCases.register(email!, password!, img!);
      
        _authProvider.setUser(user!);

        return true; 
      } on ExistentUser catch(e){      
        ToastService.error(e.getMessage());
        return false;
      } catch(e) {
        print(e);
        ToastService.error("Hubo un error");
        return false;
      }
  
  }
}