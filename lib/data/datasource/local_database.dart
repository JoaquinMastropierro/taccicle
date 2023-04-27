import 'package:sqflite/sqflite.dart';
import 'package:taccicle/data/models/Ride.dart';
import 'package:taccicle/data/models/RidePath.dart';

class LocalDatabase {

  static late Database _dbInstance;
  static  init() async {

    var databasePath = await getDatabasesPath();

    deleteDatabase("${databasePath}-rides");

   _dbInstance = await openDatabase(
      "${databasePath}-rides",
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE ride(idRide INTEGER PRIMARY KEY, created_at datetime, finished_at datetime, idColor INTEGER, creator INTEGER)",
        );

        await db.execute('CREATE TABLE ride_path(idUser INTEGER, idRide INTEGER, date datetime, speed DECIMAL(5,2), lat DECIMAL(8,6), lng DECIMAL(9,6), PRIMARY KEY (idUser, idRide, date))');
      },
      version: 1
    );  
    
  }


  static Future<bool> insert(String table, Map<String, Object?> map) async {
    return (await _dbInstance.insert(table, map)) != 0;
  }

  static Future<Ride?> findRideNotFinished(int idUser) async {

    var results = await _dbInstance.query("ride", where: "finished_at is null and creator = ?", whereArgs: [idUser]);    
    
    if(results.isNotEmpty) return Ride.fromJson(results[0]);

  }
    static Future<List<RidePath>?> findRideData(int idRide, int idUser) async {

    var results = await _dbInstance.query("ride_path", where: "idUser = ? and idRide = ?", whereArgs: [idUser, idRide]);    
    
    return results.map((e) => RidePath.fromJson(e)).toList();

  }

  
  
  
}
