import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taccicle/presentation/helpers/custom_map_marker.dart';
import 'package:taccicle/presentation/states/bloc/live_location_bloc/live_location_bloc.dart';
import 'package:flutter/services.dart';
import 'package:taccicle/presentation/states/bloc/map_bloc/map_bloc.dart';
import 'package:taccicle/presentation/states/providers/auth_provider.dart';

class RideLiveMap extends StatefulWidget {
  const RideLiveMap({super.key});

  @override
  State<RideLiveMap> createState() => _RideLiveMapState();
}

class _RideLiveMapState extends State<RideLiveMap> {

  BitmapDescriptor? personImage;

  @override
  void initState()  {
    
    super.initState();
   



  }




  @override
  Widget build(BuildContext context) {



    return Stack(
      children: [
         BlocBuilder<LiveLocationBloc, LiveLocationState>(
           builder: (context, locationState) {
             return BlocBuilder<MapBloc, MapBlocState>(
               builder: (context, mapState) {
                 return GoogleMap(
                    initialCameraPosition: CameraPosition(target: locationState.lastKnownLocation ?? LatLng(-37.32303088622129, -59.1443404907103), zoom: 15),
                    myLocationButtonEnabled: true,        
                    polylines: mapState.polyline != null ? Set.from({mapState.polyline}) : Set(),  
                    markers: {
                      Marker(markerId: const MarkerId("currentPosition"), icon: mapState.userMarkerImage ?? BitmapDescriptor.defaultMarker , position: locationState.lastKnownLocation ?? const LatLng(0, 0), )
                    },
                    onMapCreated: (controller) {
                      BlocProvider.of<MapBloc>(context).mapController = controller;                  
                    },
                  );
               }
             );
           }
         )
      ],
    );
  }
}