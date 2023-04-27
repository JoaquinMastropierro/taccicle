import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taccicle/data/models/Ride.dart';
import 'package:taccicle/domain/entities/User.dart';
import 'package:taccicle/presentation/states/bloc/live_location_bloc/live_location_bloc.dart';
import 'package:taccicle/presentation/states/bloc/map_bloc/map_bloc.dart';
import 'package:taccicle/presentation/states/providers/auth_provider.dart';
import 'package:taccicle/presentation/ui/screens/ride_live/ride_live_map/ride_live_map.dart';
import 'package:taccicle/presentation/ui/screens/ride_live/ride_live_panel/ride_live.panel.dart';

class RideLiveScreen extends StatefulWidget {

  final Ride? ride;

  const RideLiveScreen({super.key, this.ride});

  @override
  State<RideLiveScreen> createState() => _RideLiveScreenState();
}

class _RideLiveScreenState extends State<RideLiveScreen> {

  int currentPage = 0;
  final PageController pageController = new PageController( initialPage: 0);

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<AuthProvider>(context, listen: false).user!;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LiveLocationBloc(currentUser: user, ride: widget.ride)),
        BlocProvider(create: (context) => MapBloc(liveLocationBloc: BlocProvider.of<LiveLocationBloc>(context), currentUser: user ))
      ],
      
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: buildBottomNavigationBar(context),
        body: buildPageView(), 
        appBar: AppBar(
            elevation: 0,
        ),
        
      ),
    );
  }

  PageView buildPageView() { 
    return PageView(
        physics: (currentPage == 0) ? const ScrollPhysics() : const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: (index) {          
          setState(() {currentPage = index;});
        },
        children: [
           RideLivePanel(),
           RideLiveMap()
        ],
      );
  }

  BottomNavigationBar buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (index){
          currentPage = index;

          pageController.animateToPage(
            index, 
            duration: const Duration(milliseconds: 200), 
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
            label: 'Panel',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Mapa',
          )
        ],
      );
  }
}