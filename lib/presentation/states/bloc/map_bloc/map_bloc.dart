import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taccicle/domain/entities/User.dart';
import 'package:taccicle/presentation/helpers/custom_map_marker.dart';
import 'package:taccicle/presentation/states/bloc/live_location_bloc/live_location_bloc.dart';

part 'map_bloc_event.dart';
part 'map_bloc_state.dart';

class MapBloc extends Bloc<MapBlocEvent, MapBlocState> {
  
  GoogleMapController? mapController;
  LiveLocationBloc liveLocationBloc;
  StreamSubscription? streamSubscription;
  
  MapBloc({required this.liveLocationBloc, required User currentUser }) : super(MapBlocState()) {

    
    on<MapBlocEvent>((event, emit) {

    });

    on<MapInitializedEvent>((event, emit) {
      mapController = event.mapController;
    });

    on<UpdateUserPolylyneEvent>((event, emit) {

      emit(
        state.copyWith(
          polyline: Polyline(
            polylineId: const PolylineId("me"),
            points: event.userPoints,
            color: Colors.blue, width: 5, startCap: Cap.roundCap, endCap: Cap.roundCap
          )
        )
      );
    
    });

    on<markerGenerated>((event, emit) {
        emit(state.copyWith(
          userMarkerImage: event.marker
        ));
    });

    streamSubscription = liveLocationBloc.stream.listen((event) {
        add(UpdateUserPolylyneEvent(userPoints: event.locationHistory));
    });

    getBytesFromAsset(currentUser.avatar!, 135, currentUser.username, Colors.blue)
    .then((value) {
      add(markerGenerated(marker: BitmapDescriptor.fromBytes(value)));
    });

    if(liveLocationBloc.state.locationHistory.isNotEmpty){
      add(UpdateUserPolylyneEvent(userPoints: liveLocationBloc.state.locationHistory));
    }
     
  }
  
  @override
  Future<void> close() {
    if(streamSubscription != null) streamSubscription!.cancel();
    // TODO: implement close
    return super.close();
  }
}
