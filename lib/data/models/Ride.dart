class Ride {
  final int idRide;
  final DateTime createdAt;
  final DateTime? finishedAt;
  final int idColor;
  final int creator;

  Ride({required this.idRide,required this.createdAt, this.finishedAt,required this.idColor, required this.creator});


  Map<String, Object?> toMap() => {
    "idRide":idRide,
    "created_at":createdAt.toString(),
    "finished_at":finishedAt != null ? finishedAt.toString() : null,
    "idColor":idColor,
    "creator":creator
  };

  factory Ride.fromJson(Map<String, dynamic> json) => Ride(
        idRide: json["idRide"],
        createdAt: DateTime.parse(json["created_at"]),
        finishedAt: json["finished_at"],
        idColor: json["idColor"],
        creator: json["creator"],
    );


}
