import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:taccicle/data/datasource/local_database.dart';
import 'package:taccicle/data/models/Ride.dart';
import 'package:taccicle/data/repositories/local_rides_repositorie.dart';
import 'package:taccicle/presentation/states/providers/auth_provider.dart';
import 'package:taccicle/presentation/ui/screens/login/login_screen.dart';
import 'package:taccicle/presentation/ui/screens/home/home_screen.dart';
import 'package:taccicle/presentation/ui/screens/ride_live/ride_live.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool loading = true;
  Ride? ride;
  @override
  void initState() {

    checkAuthentication();
    super.initState();

  }

  void checkAuthentication() async {

    Provider.of<AuthProvider>(context, listen: false)
    .checkAuth()
    .then((user) async {

      if(user == null){
        return setState(() {
          loading = false;
        });
      }

      ride = await LocalRidesRepositorie.getRideNotFinished(user.idUser);
            
      return setState(() {
        loading = false;
      });
      
    });

    
  
  } 




  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);

    if(loading) return const LoadingSplash();

    if(!authProvider.authenticated) return const LoginScreen();

    if(ride == null) return HomeScreen();

    return RideLiveScreen(ride: ride);
  
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
              SizedBox(height: 20,),
              Image(image: AssetImage("lib/assets/images/sapobici.png"), height: 150, width: 150,),
              CircularProgressIndicator(color: Colors.white.withOpacity(0.8),),
         

            ],
          ),
        )
    );
  }
}