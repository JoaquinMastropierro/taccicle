import 'package:taccicle/data/datasource/local_database.dart';
import 'package:taccicle/data/models/Ride.dart';
import 'package:taccicle/data/models/RidePath.dart';

class LocalRidesRepositorie {
  
  static Future<bool> insertRide(Ride ride){
    return LocalDatabase.insert('ride', ride.toMap());
  }

  static void insertRidePath(RidePath ridePath){
    LocalDatabase.insert('ride_path', ridePath.toMap());
  }

  static Future<Ride?> getRideNotFinished(int idUser){
    return LocalDatabase.findRideNotFinished(idUser);
  }

  static Future<List<RidePath>?> getRideData(Ride ride, int idUser) {
    return LocalDatabase.findRideData(ride.idRide, idUser);
    
  }
}