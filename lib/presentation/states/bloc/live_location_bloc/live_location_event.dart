part of 'live_location_bloc.dart';

@immutable
abstract class LiveLocationEvent extends Equatable {}


class NewUserLocationEvent extends LiveLocationEvent{

  final LatLng newLocation;
  final double currentSpeed;
  
  NewUserLocationEvent(this.newLocation, this.currentSpeed);

  @override
  List<Object?> get props => [newLocation, currentSpeed];

}

class ChangeRideStatusEvent extends LiveLocationEvent{

  final RideStatus newStatus;

  ChangeRideStatusEvent(this.newStatus);



  @override
  List<Object?> get props => [newStatus];

}

class SecondElapsedEvent extends LiveLocationEvent{


  SecondElapsedEvent();

    @override
  List<Object?> get props => [];


}

class LoadExistingRide extends LiveLocationEvent {

  final Ride ride;

  LoadExistingRide({required this.ride});

    @override
  List<Object?> get props => [ride];


}
