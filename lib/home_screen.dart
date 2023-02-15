import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomeScreen extends StatelessWidget {

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
          children: [
            Container(
              color: Colors.amber,
              child: Center(
                child: Text('Custom Screen'),
              ),
            ),
            Container(
              color: Colors.black45,
              child: Center(
                child: Text('Custom Screen'),
              ),
            )
          ],
        ),

        bottomNavigationBar: BottomNavigationBar(
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