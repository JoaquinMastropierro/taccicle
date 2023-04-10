import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart' as g;
import  'package:permission_handler/permission_handler.dart';

class LocationProvider extends ChangeNotifier{

  bool isPermissonEnabled = false;
  bool isLocationActivated = false;

  LocationProvider(){
    _init();
    
  }

  _init() async {

    await _checkLocation();
    await _checkPermission();


    notifyListeners(); 
  }

  Future<void> _checkPermission() async {
    isPermissonEnabled = await Permission.location.isGranted;
  }

  Future<void> _checkLocation() async {
    isLocationActivated = await g.Geolocator.isLocationServiceEnabled();
    
    
    g.Geolocator.getServiceStatusStream().listen((g.ServiceStatus event) {
    
      isLocationActivated = (event.index == 1);
      notifyListeners();
    
    
    });
  }

  changePermission() async {
    
    var status = await Permission.location.request();
    print(status);
    if(status.isGranted){
      isPermissonEnabled = true;
      return notifyListeners();      
    }

    await openAppSettings();

  }


  

}