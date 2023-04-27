part of 'live_location_bloc.dart';


enum RideStatus {
  initialized, // entras y no tocaste play
  creatingRide, // tocaste play y esta creando la ride. remota.
  riding, // andando.
  paused, // pusiste pausa.
  finished // terminaste la raid manualmente.
}

@immutable
class LiveLocationState  extends Equatable {

  final LatLng? lastKnownLocation;
  final List<LatLng> locationHistory;
  final double? currentSpeed;
  final List<double> speedHistory;
  final double speedAvg;
  final double distance;

  final RideStatus status;
  final int secondsElapsed;
  final bool defaultRide;

  const LiveLocationState({
    this.lastKnownLocation,   
    this.status = RideStatus.initialized,
    locationHistory,
    this.secondsElapsed = 0,
    this.currentSpeed,
    speedHistory,
    this.speedAvg = 0,
    this.distance = 0,
    this.defaultRide = false
  }) :
    locationHistory =  locationHistory ?? const [], 
    speedHistory =  speedHistory ?? const [];

  
  
  
  LiveLocationState copyWith({
   LatLng? lastKnownLocation,
   List<LatLng>? locationHistory,
   RideStatus? status,
   int? secondsElapsed,
   double? currentSpeed,
   List<double>? speedHistory,
   double? speedAvg,
   double? distance

  }) => LiveLocationState(
    lastKnownLocation: lastKnownLocation ?? this.lastKnownLocation,
    status: status ?? this.status,
    locationHistory: locationHistory ?? this.locationHistory,
    secondsElapsed: secondsElapsed ?? this.secondsElapsed,
    currentSpeed: currentSpeed ?? this.currentSpeed,
    speedHistory: speedHistory ?? this.speedHistory,
    speedAvg: speedAvg ?? this.speedAvg,
    distance: distance ?? this.distance
  );

  @override
  List<Object?> get props => [status, locationHistory, lastKnownLocation, secondsElapsed, currentSpeed, speedHistory, speedAvg, distance];

 


}
