import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taccicle/domain/entities/User.dart';
import 'package:taccicle/domain/user_cases/auth_user_cases.dart';
import 'package:taccicle/presentation/providers/auth_provider.dart';

class HomeDrawer extends StatelessWidget {
  
  const HomeDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    User loggedUser = authProvider.user!;

    logout() async {
      bool logout = await authUserCases.logout();

      if (logout) authProvider.logoutUser();
    }

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding:const EdgeInsets.all(0),
            child: Stack(
              children: [
                const Positioned.fill(
                        child: Image(
                            image: AssetImage("lib/assets/images/juaco.png"),
                            fit: BoxFit.fill))
                    .blurred(blur: 3, colorOpacity: 0),
                Positioned(
                  bottom: 15,
                  right: 40,
                  child: Text(loggedUser.name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600)),
                )
              ],
            ),
          ),
          Flexible(
              flex: 5,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    outlinedButton(authProvider, "Configuracion", () {}),
                    outlinedButton(authProvider, ":D", () {}),
                    Spacer(),
                    outlinedButton(authProvider, "Salir", logout)
                  ],
                ),
              ))
        ],
      ),
    );
  }

  OutlinedButton outlinedButton(
      AuthProvider authProvider, String text, void Function() onPress) {
    return OutlinedButton(
        onPressed: onPress,
        child: Container(
          width: double.infinity,
          child: Center(child: Text(text)),
        ));
  }
}
