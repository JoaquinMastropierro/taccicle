import 'package:flutter/material.dart';
import 'package:taccicle/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen()
    );
  }   //CREO QUE PARA PONER EL ICONO DE ANDA EN BICI HAY QUE USAR UN Stack QUE HACE QUE FLOTE UN WIDGET
}
