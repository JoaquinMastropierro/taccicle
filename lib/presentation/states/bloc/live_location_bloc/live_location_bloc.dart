import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taccicle/data/models/Ride.dart';
import 'package:taccicle/data/models/RidePath.dart';
import 'package:taccicle/data/repositories/local_rides_repositorie.dart';
import 'package:taccicle/domain/entities/User.dart';
import 'package:taccicle/domain/user_cases/ride_user_cases.dart';
import 'package:taccicle/presentation/helpers/locations_functions.dart';

part 'live_location_event.dart';
part 'live_location_state.dart';

class LiveLocationBloc extends Bloc<LiveLocationEvent, LiveLocationState> {
  
  StreamSubscription<Position>? positionStream;
  Timer? _timer; 

  final User currentUser;
  late final Ride currentRide;

  LiveLocationBloc({required this.currentUser, Ride? ride}) : super(LiveLocationState(defaultRide: (ride != null))) {



    on<LiveLocationEvent>((event, emit) {});

    on<NewUserLocationEvent>((event, emit){

      var newPoints = [...state.locationHistory, event.newLocation];

      LocalRidesRepositorie.insertRidePath(RidePath(currentUser.idUser, currentRide.idRide, DateTime.now(), event.currentSpeed, event.newLocation.latitude, event.newLocation.longitude));
      
      double distanceTravelled = 0;

      if(state.lastKnownLocation != null){
        distanceTravelled = LocationsFunctions.calculateDistance(state.lastKnownLocation!.latitude, event.newLocation.latitude, state.lastKnownLocation!.longitude, event.newLocation.longitude);
      } 

      emit(state.copyWith(
        lastKnownLocation: event.newLocation,
        locationHistory: newPoints,
        currentSpeed: event.currentSpeed,
        speedHistory: [...state.speedHistory, event.currentSpeed],
        speedAvg: state.speedAvg + (event.currentSpeed - state.speedAvg) / newPoints.length,
        distance: state.distance + distanceTravelled
      ));

    });


    on<ChangeRideStatusEvent>((event, emit) {
      
      
      bool itsFirstStart = event.newStatus == RideStatus.creatingRide;

      emit(state.copyWith(
        status: event.newStatus
      ));

      bool hasToStartTimer = (event.newStatus == RideStatus.initialized || event.newStatus == RideStatus.riding || event.newStatus == RideStatus.creatingRide);

      if(hasToStartTimer) startRide(itsFirstStart);

      bool hasToStopTimer = (event.newStatus == RideStatus.paused ||  event.newStatus == RideStatus.finished);

      if(hasToStopTimer) stopRide();
      

    });

    on<SecondElapsedEvent>((event, emit) {
      
      emit(state.copyWith(
        secondsElapsed: state.secondsElapsed + 1
      ));

    });

    on<LoadExistingRide>((event, emit) async {
      
      currentRide = event.ride;
      
      var state = await RideUserCases.getLiveRideState(currentRide, currentUser.idUser);

      emit(state);

    });

    if(ride != null){
      add(LoadExistingRide(ride:ride));
    }


  }




  void startRide(bool itsFirstStart){

     if(itsFirstStart) {

      RideUserCases.createLocalRide(currentUser.idUser).then((ride) {
        add(ChangeRideStatusEvent(RideStatus.riding));
        currentRide = ride;
      });

     return;
     
    } 

    
    _timer = Timer.periodic(const Duration(seconds: 1), (time) {
      add(SecondElapsedEvent());
    });
      
         
    startFollowingUser();
           
  }

   void stopRide(){

    if(positionStream != null) positionStream!.pause();
    if(_timer != null) _timer!.cancel();

  }

  void startFollowingUser(){
    
    if(positionStream == null ){
      positionStream = Geolocator.getPositionStream().listen((event) { 
        
        final position = event;
        add(NewUserLocationEvent(LatLng(position.latitude, position.longitude), position.speed));
          
      });
    } else {
      positionStream!.resume();
    }
   

  
    
  }

  String printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }



  @override
  Future<void> close() {
    // TODO: implement close
    if(positionStream != null) positionStream!.cancel();

    return super.close();
  }

}
