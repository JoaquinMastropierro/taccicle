class RidePath {
  final int idUser;
  final int idRide;
  final DateTime date;
  final double speed;
  final double lat;
  final double lng;

  RidePath(this.idUser, this.idRide, this.date, this.speed, this.lat, this.lng);

  Map<String, Object?> toMap() => {
        "idUser": idUser,
        "idRide": idRide,
        "date": date.toString(),
        "speed": speed,
        "lat": lat,
        "lng": lng
      };

  factory RidePath.fromJson(Map<String, dynamic> json) => RidePath(
        json["idUser"],
        json["idRide"],
        DateTime.parse(json["date"]),
        json["speed"],
        json["lat"],
        json["lng"],
      );

  @override
  String toString() {
    // TODO: implement toString
    return "fecha: ${date.toString()} ${lat } -- ${lng} | ";
  }
}
