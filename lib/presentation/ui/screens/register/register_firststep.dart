import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:taccicle/domain/entities/User.dart';
import 'package:taccicle/presentation/providers/form_provider/register_form_provider.dart';
import 'package:taccicle/presentation/ui/common/inputs/custom_shadow_input.dart';

class RegisterFirstStep extends StatelessWidget {
  const RegisterFirstStep({super.key});

  @override
  Widget build(BuildContext context) {
    final registerFormProvider = Provider.of<RegisterFormProvider>(context);


    String? repeatedPassword(String? value) {
      return (value ?? '') == registerFormProvider.password
          ? null
          : "La clave debe ser igual";
    }

    String? validate8length(String? value) {
    return (value?.length ?? 0) >= 8 ? null : "Minimo 8 caracteres";
  }

    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: registerFormProvider.formkey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            CustomShadowedInput(
              hintText: "Nombre de Usuario",
              validation: User.validateUsername,
              onChange: (p0) => registerFormProvider.email = p0,
            ),
            const SizedBox(
              height: 25,
            ),
            CustomShadowedInput(
              hintText: "Contraseña",
              validation: validate8length,
              onChange: (p0) => registerFormProvider.password = p0,
              obscureText: true,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomShadowedInput(
              hintText: "Repetir contraseña",
              validation: repeatedPassword,
              onChange: (p0) => registerFormProvider.repeatedPassword = p0,
              obscureText: true,
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
   
  }
 

  
 
}