import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:taccicle/presentation/providers/auth_provider.dart';
import 'package:taccicle/presentation/ui/screens/login/login_screen.dart';
import 'package:taccicle/presentation/ui/screens/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool loading = true;
  
  @override
  void initState() {

    checkAuthentication();
    super.initState();

  }

  void checkAuthentication() {

   
    Provider.of<AuthProvider>(context, listen: false).checkAuth(context)
    .then((dato) => 
      setState(() {
        loading = false;
      }));
  

  }




  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);

    return loading ? const LoadingSplash() : (

      authProvider.authenticated ? HomeScreen() : const LoginScreen()

    );
  }
}

class LoadingSplash extends StatelessWidget {
  const LoadingSplash({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).primaryColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ 
              //Text("Tacicle", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white, decoration: TextDecoration.none),),
              SizedBox(height: 20,),
              Image(image: AssetImage("lib/assets/images/sapobici.png"), height: 150, width: 150,),
              CircularProgressIndicator(color: Colors.white.withOpacity(0.8),),
         

            ],
          ),
        )
    );
  }
}