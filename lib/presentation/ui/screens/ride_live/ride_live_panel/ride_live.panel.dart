import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taccicle/presentation/states/bloc/live_location_bloc/live_location_bloc.dart';
import 'package:taccicle/presentation/ui/screens/ride_live/ride_live_panel/ride_live_panel_header.dart';

class RideLivePanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [RideLivePanelHeader(), actionsRow(context), realTimeStatsBuilder()],
    );
  }

 
 Widget realTimeStatsBuilder(){
    return BlocBuilder<LiveLocationBloc, LiveLocationState>(
      builder: (context, state) {
        if(state.status != RideStatus.initialized){
          return realtimeStatsRow();
        }

        return SizedBox();
        
      }
    );
 }

 Expanded realtimeStatsRow() {
   return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Color.fromARGB(255, 202, 202, 202)), right: BorderSide(width: 1, color: Color.fromARGB(255, 202, 202, 202)))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                              BlocBuilder<LiveLocationBloc, LiveLocationState>(
                            builder: (context, state) {
                              return Text("${state.distance.toStringAsFixed(2)} km", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),);
                            }
                          ),
                          Text("distancia recorrida", style: TextStyle(fontSize: 12))
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Color.fromARGB(255, 202, 202, 202)))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("465 kcals", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),),
                          Text("Calorias quemadas", style: TextStyle(fontSize: 12))
                        ],
                      ),
                    ),
                  )
                ],
              ),
               Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(border: Border(right: BorderSide(width: 1, color: Color.fromARGB(255, 202, 202, 202)))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BlocBuilder<LiveLocationBloc, LiveLocationState>(
                            builder: (context, state) {
                              return Text("${state.speedAvg.toStringAsFixed(2)} km/h", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),);
                            }
                          ),
                          Text("Velocidad Promedio", style: TextStyle(fontSize: 12))
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BlocBuilder<LiveLocationBloc, LiveLocationState>(
                            builder: (context, state) {
                              return Text("${state.distance.toStringAsFixed(2)} km", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),);
                            }
                          ),
                          Text("distancia recorrida", style: TextStyle(fontSize: 12))
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
 }

  Widget actionsRow(context) {
    final locationBloc = BlocProvider.of<LiveLocationBloc>(context);

    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: BlocBuilder<LiveLocationBloc, LiveLocationState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {

        if (state.status == RideStatus.initialized) return actionRowWhenInitialized(colorScheme, locationBloc);

        if (state.status == RideStatus.creatingRide) return CircularProgressIndicator();
                
        return actionRowWhenInRidePaused(colorScheme, state, locationBloc);
      }),
    );
  }

  Row actionRowWhenInRidePaused(ColorScheme colorScheme, LiveLocationState state, LiveLocationBloc locationBloc) {
    return Row(
        children: [
          Expanded(
            child: playpauseButton(colorScheme, state.status == RideStatus.paused, (){
              
              
            state.status == RideStatus.paused ?
              locationBloc.add(ChangeRideStatusEvent(RideStatus.riding))
              :
              locationBloc.add(ChangeRideStatusEvent(RideStatus.paused));
              
      
                              
            }),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(child: resumeButton(colorScheme)),
        ],
      );
  }

  Row actionRowWhenInitialized(ColorScheme colorScheme, LiveLocationBloc locationBloc) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              child: playpauseButton(colorScheme, true, () => locationBloc.add(ChangeRideStatusEvent(RideStatus.creatingRide))
              )
            )
          ],
        );
  }

  Widget playpauseButton(colorScheme, bool isPlay, void Function() onPress) {
    return ElevatedButton(
        onPressed: onPress,
        child: SizedBox(height: 80, child: Icon(isPlay ? Icons.play_arrow : Icons.pause, size: 35)));
  }

  Widget resumeButton(colorScheme) {
    return ElevatedButton(
        style: TextButton.styleFrom(
          backgroundColor: colorScheme.error, // foreground
        ),
        onPressed: () {},
        child: const SizedBox(
            height: 80, child: Icon(Icons.stop_circle, size: 35)));
  }
}

