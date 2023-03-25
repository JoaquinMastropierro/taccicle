import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taccicle/data/datasource/backend_api.dart';
import 'package:taccicle/data/datasource/storage.dart';
import 'package:taccicle/presentation/providers/auth_provider.dart';
import 'package:taccicle/presentation/services/toast_service.dart';
import 'package:taccicle/presentation/ui/screens/login/login_screen.dart';
import 'package:taccicle/presentation/ui/screens/splash/splash_screen.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized(); 
  await Storage.configurePrefs();
  BackendApi.configureDio();


  runApp(const MyApp());

}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      
      create: (BuildContext context) => AuthProvider(),
      child: MainApp()
      
      );
  }

  MaterialApp MainApp() {
    return MaterialApp(
    scaffoldMessengerKey: ToastService.messengerKey,
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor:const Color.fromARGB(255, 59, 131, 190),
      shadowColor: Color.fromARGB(255, 161, 161, 161),
      canvasColor: Colors.white,
      colorScheme: const ColorScheme(brightness: Brightness.light, primary: Color.fromARGB(255, 59, 131, 190), onPrimary: Colors.white, secondary: Colors.pinkAccent, onSecondary: Colors.pinkAccent, error: Color.fromARGB(255, 255, 71, 71), onError: Colors.white, background: Colors.white, onBackground: Color.fromARGB(255, 207, 200, 200), surface: Color.fromARGB(255, 255, 255, 255), onSurface: Color.fromARGB(255, 56, 56, 56))      

    ), 
    darkTheme: ThemeData(
      canvasColor: const Color.fromARGB(255, 61, 59, 59),
      primaryColor:const Color.fromARGB(255, 59, 131, 190),
      shadowColor: Colors.transparent,
      colorScheme: const ColorScheme(brightness: Brightness.dark, primary: Color.fromARGB(255, 59, 131, 190), onPrimary: Colors.white, secondary: Colors.pinkAccent, onSecondary: Colors.pinkAccent, error: Color.fromARGB(255, 221, 140, 134), onError: Color.fromARGB(1, 87, 85, 85), background: Colors.black38, onBackground: Colors.white, surface: Color.fromARGB(255, 43, 42, 42), onSurface: Colors.white)      
    ),
    home: const SplashScreen(),
    
  );
  }   
}
