import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taccicle/data/datasource/backend_api.dart';
import 'package:taccicle/data/models/Ride.dart';
import 'package:taccicle/data/repositories/local_rides_repositorie.dart';
import 'package:taccicle/data/repositories/remote_rides_repositorie.dart';
import 'package:taccicle/presentation/helpers/locations_functions.dart';
import 'package:taccicle/presentation/states/bloc/live_location_bloc/live_location_bloc.dart';

class RideUserCases {
  static Future<Ride> createLocalRide(idUser) async {

    Ride ride = await RemoteRidesRepositorie.createRemoteRide(idUser); // Creo la ride Remotamente.

    bool insertedLocaly = await LocalRidesRepositorie.insertRide(ride); // La inserto en la base de datos Local.

    return ride;
  }

  static Future<LiveLocationState> getLiveRideState(Ride ride, int idUser) async {
    var ridePathList = await LocalRidesRepositorie.getRideData(ride, idUser);

    if(ridePathList == null) return LiveLocationState();
   
    double distance = 0;
    double speedTotal = 0;
    List<LatLng> locationHistory = [];
    List<double> speedHistory = [];
   
    int index = 0;

    ridePathList.forEach((element) {

        speedTotal += element.speed;
        locationHistory.add(LatLng(element.lat, element.lng));
        speedHistory.add(element.speed);

        if(index < ridePathList.length - 1){
          var nextEl = ridePathList.elementAt(index + 1);
          distance += LocationsFunctions.calculateDistance(element.lat, nextEl.lat, element.lng, nextEl.lng);
        }

        index++;
                 
    });


    return LiveLocationState(
      lastKnownLocation: LatLng(ridePathList.last.lat, ridePathList.last.lng),
      currentSpeed: ridePathList.last.speed,
      secondsElapsed: ridePathList.last.date.difference(ridePathList.first.date).inSeconds,
      status: RideStatus.paused,
      speedAvg: speedTotal / ridePathList.length,
      distance: distance,
      speedHistory: speedHistory,
      locationHistory: locationHistory

    );
  }
}