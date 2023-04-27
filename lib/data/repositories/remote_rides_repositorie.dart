import 'package:taccicle/data/datasource/backend_api.dart';
import 'package:taccicle/data/models/Ride.dart';

class RemoteRidesRepositorie {


  static Future<Ride> createRemoteRide(int idUser) async {
    final response = await BackendApi.httpPost("/ride", {"idUser": idUser});
    return Ride.fromJson(response['ride']);
  }

}