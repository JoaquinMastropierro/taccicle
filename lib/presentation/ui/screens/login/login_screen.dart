import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taccicle/domain/entities/User.dart';
import 'package:taccicle/presentation/providers/auth_provider.dart';
import 'package:taccicle/presentation/providers/form_provider/login_form_provider.dart';
import 'package:taccicle/presentation/ui/common/inputs/button_with_loading.dart';
import 'package:taccicle/presentation/ui/common/inputs/custom_shadow_input.dart';
import 'package:taccicle/presentation/ui/screens/register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginFormProvider(
        Provider.of<AuthProvider>(context)
      ),
      child: const Scaffold(
        resizeToAvoidBottomInset: false,
        body: LoginView(),
      ),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final loginFormProvider =
        Provider.of<LoginFormProvider>(context, listen: false);

    final colorScheme = Theme.of(context).colorScheme;

    var loginHeader = Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius:const BorderRadius.vertical(bottom: Radius.circular(50))
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:  [
          SizedBox(height: 30),
          Text(
            "Bienvenido mi Pana",
            style: TextStyle(color: colorScheme.onPrimary, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            "Como andas",
            style: TextStyle(color: colorScheme.onPrimary, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(height: 15)
        ],
      ),
    );

     

    var noAccountText = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "No tenes cuenta? ",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 110, 110, 110)),
            ),
            GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RegisterPage())),
                child: Text("Registrate aca.",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary)))
          ],
        );
    
    var formBody = Column(
      children: [
        const SizedBox(height: 50),
        CustomShadowedInput(
          hintText: "Nombre del usuario",
          validation: User.validateUsername,
          onChange: (username) => loginFormProvider.username = username,
        ),
        const SizedBox(height: 10),
        CustomShadowedInput(
          hintText: "Contraseña",
          validation: validate8length,
          onChange: (password) => loginFormProvider.password = password,
          obscureText: true,
        ),
        const SizedBox(height: 15),
        noAccountText,
        const SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: ButtonWithLoading(onPress: () => loginFormProvider.login(context),
          buttonContent: buttonContent(), 
          height: 60,
          ),
        )
      ],
    );

    var body = Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Form(
          key: loginFormProvider.formkey,
          child: formBody,
          
        ),
      ),
    );

    return Column(
      children: [loginHeader, body],
    );
  }

  Text buttonContent() {
    return const Text(
        "Entrar",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        );
  }

  String? validate8length(String? value) {
          return (value?.length ?? 0) >= 8 ? null : "Minimo 8 caracteres";
        }
}

