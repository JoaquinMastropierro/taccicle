import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taccicle/domain/entities/User.dart';
import 'package:taccicle/presentation/providers/auth_provider.dart';
import 'package:taccicle/presentation/providers/form_provider/register_form_provider.dart';
import 'package:taccicle/presentation/ui/common/inputs/button_with_loading.dart';
import 'package:taccicle/presentation/ui/common/inputs/custom_shadow_input.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {

    final colorScheme = Theme.of(context).colorScheme;


    return ChangeNotifierProvider(
      create: (_) => RegisterFormProvider(Provider.of<AuthProvider>(context)),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: colorScheme.primary,
            elevation: 0,
          ),
          body: const RegisterView()),
    );
  }
}

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});


  @override
  Widget build(BuildContext context) {
    final registerFormProvider = Provider.of<RegisterFormProvider>(context, listen: false);
    final colorScheme = Theme.of(context).colorScheme;
        
  String? repeatedPassword(String? value) {
    return (value ?? '') == registerFormProvider.password ? null : "La clave debe ser igual";
  }

    var header = Container(
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
      ),
      padding: const EdgeInsets.all(25),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Registrate",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Es Facil",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 25,
          )
        ],
      ),
    );

   

    Future onPressButton() async {

         await registerFormProvider.validateForm().then((valid) => {if(valid) Navigator.pop(context)});

    }
    var textButton = ButtonWithLoading(onPress: onPressButton, height: 45, buttonContent: buttonContent());

    return Column(children: [
      header,
      Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: registerFormProvider.formkey,
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              children: [
                const SizedBox(height: 50),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: textButton,
                )
                
              ],
            ),
          ),
        ),
      )
    ]);
    
  }

  Text buttonContent() {
    return const Text(
          "Registrarse",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        );
  }

  String? validate8length(String? value) {
    return (value?.length ?? 0) >= 8 ? null : "Minimo 8 caracteres";
  }

}
