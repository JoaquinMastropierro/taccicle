part of 'map_bloc.dart';

 class MapBlocState extends Equatable {
  
  final Polyline? polyline;
  final BitmapDescriptor? userMarkerImage;
  
  const MapBlocState({this.polyline, this.userMarkerImage});
  

  @override
  List get props => [polyline, userMarkerImage];

  copyWith({Polyline? polyline, BitmapDescriptor? userMarkerImage}) => MapBlocState(
    polyline: polyline ?? this.polyline,
    userMarkerImage: userMarkerImage ?? this.userMarkerImage
  );
}


