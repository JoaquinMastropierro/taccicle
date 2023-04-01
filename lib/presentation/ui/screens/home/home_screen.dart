import 'package:flutter/material.dart';
import 'package:taccicle/presentation/ui/screens/friends/friends_list.dart';
import 'package:taccicle/presentation/ui/screens/home/history/history_list_screen.dart';
import 'package:taccicle/presentation/ui/screens/home/home_drawer.dart';
import 'package:taccicle/presentation/ui/screens/home/main/main_panel.dart';

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

    return Scaffold(

      floatingActionButton: FloatingActionButton(
        onPressed: () => {}, backgroundColor: Theme.of(context).primaryColor,

      ), 
      drawer: HomeDrawer(),

      appBar: AppBar(
          title: const Text( 'taccicle' ),
          backgroundColor: colorScheme.primary,
        ),

        body: PageView(
          //physics: NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: (index) {
            currentPage = index;
            setState(() {});
          },
          children: [
            MainPanel(),
            HistoryListScreen(),
            FriendsList()
          ],
        ),

        bottomNavigationBar: BottomNavigationBar(
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
        ),
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