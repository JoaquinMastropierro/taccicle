import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taccicle/domain/entities/User.dart';
import 'package:taccicle/domain/user_cases/auth_user_cases.dart';
import 'package:taccicle/presentation/states/providers/auth_provider.dart';

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
            padding: EdgeInsets.zero,
            child: Stack(
              children: [
                Positioned.fill(
                    child: Image.network(
                  loggedUser.avatar!,
                  fit: BoxFit.fill,
                  loadingBuilder: (context, child, loadingProgress) =>
                      loadingBuilder(context, child, loadingProgress),
                )).blurred(blur: 30, colorOpacity: 0),
                Positioned(
                  bottom: 15,
                  right: 40,
                  child: Text(loggedUser.username,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600)),
                ),
                Positioned(
                  bottom: 15,
                  left: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.deepOrange,
                    radius: 25,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(loggedUser.avatar!),
                      radius: 23,
                    ),
                  ),
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
                    const Spacer(),
                    outlinedButton(authProvider, "Salir", logout)
                  ],
                ),
              ))
        ],
      ),
    );
  }

  loadingBuilder(context, child, ImageChunkEvent? loadingProgress) {
    if (loadingProgress == null) return child;

    return Center(
      child: CircularProgressIndicator(),
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
