import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text( 'taccicle' ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.yellow,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.5),
          items: [
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