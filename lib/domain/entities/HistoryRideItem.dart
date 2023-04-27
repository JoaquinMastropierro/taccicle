import 'package:flutter/material.dart';

class HistoryRideItem {

  final String distancia;
  final String duracion;
  final DateTime HoraInicio;
  final int participantes;
  final String creador;
  late Color? colorSalida;
  late Color? colorSalidaAscent; 
  HistoryRideItem(this.distancia, this.duracion, this.HoraInicio, this.participantes, this.creador, this.colorSalida, this.colorSalidaAscent);
  
}