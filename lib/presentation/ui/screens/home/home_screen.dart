
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taccicle/presentation/states/providers/location_provider.dart';
import 'package:taccicle/presentation/ui/screens/friends/friends_list.dart';
import 'package:taccicle/presentation/ui/screens/home/history/history_list_screen.dart';
import 'package:taccicle/presentation/ui/screens/home/home_drawer.dart';
import 'package:taccicle/presentation/ui/screens/home/main/main_panel.dart';
import 'package:taccicle/presentation/ui/screens/ride_live/ride_live.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;
  final PageController pageController = new PageController( initialPage: 0);

 @override
  Widget build(BuildContext context) {

    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;
    
    var locationProvider = Provider.of<LocationProvider>(context);
  
    print(locationProvider.isLocationActivated && locationProvider.isPermissonEnabled);

    bool canCreateRide = locationProvider.isLocationActivated && locationProvider.isPermissonEnabled;

    return Scaffold(

      floatingActionButton: FloatingActionButton(
        
        onPressed: canCreateRide ? navigateToCreateRide : null, 
        backgroundColor: canCreateRide ?Theme.of(context).primaryColor : Colors.grey,
        foregroundColor: Colors.white,
        child: Icon(canCreateRide ? Icons.add : Icons.priority_high),

      ), 
      drawer:const HomeDrawer(),
      appBar: AppBar(
          title: const Text( 'taccicle' ),
          backgroundColor: colorScheme.primary,
        ),

        body: PageView(
          controller: pageController,
          onPageChanged: (index) {
            currentPage = index;
            setState(() {});
          },
          children: [
            MainPanel(),
            HistoryListScreen(),
            const FriendsList()
          ],
        ),

        bottomNavigationBar: buildBottomNavigationBar(context),
    ); 
  }

  void navigateToCreateRide() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RideLiveScreen()));

 BottomNavigationBar buildBottomNavigationBar(BuildContext context) {
   return BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (index){
          currentPage = index;

          pageController.animateToPage(
            index, 
            duration: Duration(milliseconds: 200), 
            curve: Curves.easeOutCubic
          );

          setState(() {});
        },

        backgroundColor: Theme.of(context).colorScheme.primary,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.5),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.query_stats),
            label: 'Principal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historial',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Amigos',
          ),
        ],
      );
 }
}



// Scaffold(
//         appBar: AppBar(
//           title: const Text( 'taccicle' ),
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           items: [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.abc),
//               label: 'jo',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.abc),
//               label: 'jo',
//             )
//           ],
//         ),
//       )