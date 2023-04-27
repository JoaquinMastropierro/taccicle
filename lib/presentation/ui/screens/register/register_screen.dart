import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taccicle/domain/entities/User.dart';
import 'package:taccicle/presentation/states/providers/auth_provider.dart';
import 'package:taccicle/presentation/states/providers/form_provider/register_form_provider.dart';
import 'package:taccicle/presentation/ui/common/inputs/button_with_loading.dart';
import 'package:taccicle/presentation/ui/common/inputs/cancel_button.dart';
import 'package:taccicle/presentation/ui/common/inputs/custom_shadow_input.dart';
import 'package:taccicle/presentation/ui/screens/home/home_screen.dart';
import 'package:taccicle/presentation/ui/screens/register/register_firststep.dart';
import 'package:taccicle/presentation/ui/screens/register/register_secondstep.dart';

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

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final registerFormProvider =
        Provider.of<RegisterFormProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;

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
      final validForm = await registerFormProvider.validateForm();
    }

    return Column(children: [
      header,
      Expanded(child: buildStepper(registerFormProvider))
    ]);
  }

  Stepper buildStepper(RegisterFormProvider registerFormProvider) {
    return Stepper(
        type: StepperType.horizontal,
        currentStep: currentStep,
        onStepContinue: incrementStep,
        onStepCancel: decrementStep,
        controlsBuilder: (context, details) {
          if (details.currentStep == 0) {
            return buildContinueButton(() async {
              final validForm = await registerFormProvider.validateForm();

              if (validForm) details.onStepContinue!();
            }, "Continuar");
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 100,
                child: CancelButton(
                  content: Text(
                    "Volver",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {
                    setState(() {
                      currentStep = 0;
                    });
                  },
                ),
              ),
              SizedBox(
                width: 100,
                child: buildContinueButton(handleRegisterButton, "Registrarse", disabled: !registerFormProvider.pickedImage),
              ),
            ],
          );
        },
        steps: [
          Step(
              title: Text("Datos Basicos"),
              content: RegisterFirstStep(),
              isActive: currentStep >= 0),
          Step(
              title: Text("Avatar"),
              content: RegisterSecondStep(),
              isActive: currentStep >= 1)
        ]);
  }

  Future handleRegisterButton() async {

    final registerFormProvider = Provider.of<RegisterFormProvider>(context, listen: false);
    
    await registerFormProvider.register().then((value) {
        if(value) {
          Navigator.pop(context);
        }
    });

  }

  ButtonWithLoading buildContinueButton(Future<dynamic> onPressButton(), String text, {bool disabled = false}) {
    
    return ButtonWithLoading( onPress: onPressButton, height: 45, buttonContent: buttonContent(text), isDisabled: disabled,);
  }

  void decrementStep() {
    setState(() {
      if (currentStep == 1) currentStep--;
    });
  }

  void incrementStep() {
    setState(() {
      if (currentStep == 0) currentStep++;
    });
  }

  Text buttonContent(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
    );
  }
}
