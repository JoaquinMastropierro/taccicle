part of 'map_bloc.dart';

abstract class MapBlocEvent extends Equatable {
  const MapBlocEvent();

}


class MapInitializedEvent extends MapBlocEvent{

  final GoogleMapController mapController;

  MapInitializedEvent(this.mapController);

  @override
  List<Object?> get props => [mapController];


}

class UpdateUserPolylyneEvent extends MapBlocEvent {

  final List<LatLng> userPoints;

  const UpdateUserPolylyneEvent({required this.userPoints});

  @override
  List get props => [userPoints];

}

class markerGenerated extends MapBlocEvent {

  final BitmapDescriptor marker;

  const markerGenerated({required this.marker});

  @override
  List get props => [marker];

}