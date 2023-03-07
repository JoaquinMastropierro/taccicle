import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:taccicle/main_panel.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;
  final PageController pageController = new PageController( initialPage: 0);

 @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton(
        onPressed: () => {}, backgroundColor: Color.fromARGB(255, 11, 4, 69),
      ), 

      appBar: AppBar(
          title: const Text( 'taccicle' ),
        ),

        body: PageView(
          //physics: NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: (index) {
            currentPage = index;
            setState(() {});
          },
          children: [
            main_panel(),
            Container(
              color: Colors.black45,
              child: Center(
                child: Text('Custom Screen'),
              ),
            ),
            Container(
              color: Colors.red,
              child: Center(
                child: Text('Custom Screen2'),
              ),
            ),
          ],
        ),

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentPage,
          onTap: (index){
            currentPage = index;

            pageController.animateToPage(
              index, 
              duration: Duration(minutes: 1), 
              curve: Curves.linear
            );

            setState(() {});
          },

          backgroundColor: Color.fromARGB(255, 11, 4, 69),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.5),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.abc),
              label: 'principal',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.abc),
              label: 'historial',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.abc),
              label: 'cositas',
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