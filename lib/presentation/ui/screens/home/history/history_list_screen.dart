import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:taccicle/domain/entities/Salida.dart';

class HistoryListScreen extends StatelessWidget {
  HistoryListScreen({super.key});

  final test = [
     Salida("32 Km", "3 Horas 2 minutos", DateTime.now(), 3, "Jerepepe",const Color.fromARGB(255, 107, 1, 255), Colors.white.withOpacity(0.90)),
     Salida("12 Km", "1 Horas 12 minutos", DateTime(2023, 4, 15, 15, 1, 22), 1, "Jere", Color.fromARGB(255, 180, 96, 96), Colors.white.withOpacity(0.90)),
     Salida("15 Km", "1 Horas 33 minutos", DateTime(2023, 4, 15, 15, 2, 22), 1, "Jere", const Color(0xF5F3C100), Colors.black54),
     Salida("32 Km", "3 Horas 2 minutos", DateTime(2023, 4, 13, 15, 3, 22), 3, "Jerepepe",const Color.fromARGB(255, 107, 1, 255), Colors.white.withOpacity(0.90)),
     Salida("12 Km", "1 Horas 12 minutos", DateTime(2023, 4, 11, 15, 4, 22), 1, "Jere", const Color.fromARGB(255, 39, 225, 194), Colors.black54),
     Salida("15 Km", "1 Horas 33 minutos", DateTime(2023, 4, 11, 15, 5, 22), 1, "Jere", const Color.fromARGB(255, 25, 54, 109), Colors.white.withOpacity(0.90)),
  ];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;

    BoxDecoration cardDecoration(Salida salida) {
      return  BoxDecoration(
          //color: salida.colorSalida,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          gradient: LinearGradient(
            colors: [salida.colorSalida!, salida.colorSalida!.withOpacity(0.3), salida.colorSalida! ],
                    begin: const FractionalOffset(0, 0),
                    end: const FractionalOffset(1, 1),
                    stops: [0.0, 0.3, 1],
                    tileMode: TileMode.clamp,

          ),
          boxShadow: [
            BoxShadow(
                color: theme.shadowColor,
                spreadRadius: 2,
                blurRadius: 5
            )
          ]);
    }

    Container cardContainer(Salida salida) {
      String hora = DateFormat("hh:mm").format(salida.HoraInicio);

      return Container(
        decoration: cardDecoration(salida),
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
        height: 120,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(hora, style: TextStyle(color: salida.colorSalidaAscent, fontSize: 25, fontWeight: FontWeight.w600),), Spacer(), Text(salida.duracion, style: TextStyle(color: salida.colorSalidaAscent, fontSize: 15, fontWeight: FontWeight.w500),)],
            ),
            const Spacer(),
            Row(
              children: [
                Row(
                  children: [
                     Icon(Icons.pedal_bike_sharp, size: 25, color: salida.colorSalidaAscent,),
                    const SizedBox(width: 5),
                    Text(salida.distancia, style: TextStyle(color: salida.colorSalidaAscent, fontSize: 18),)
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(Icons.person, size: 25, color: salida.colorSalidaAscent),
                    Text(salida.participantes.toString(), style: TextStyle(color: salida.colorSalidaAscent, fontSize: 15, fontWeight: FontWeight.w600),)
                  ],
                )
              ],
            )
          ],
        ),
      );
  }
    
    return ListView.builder(
      
      itemCount: test.length,
      itemBuilder: (BuildContext context, int index) {

        var ultimaFecha = index == 0 ? null : test[index-1].HoraInicio;
        var fechaIteracionActual = test[index].HoraInicio;

        Widget divider = SizedBox(height: 1,);

        if(ultimaFecha == null || DateFormat('MM-dd-yy').parse(ultimaFecha.toString()) != DateFormat('MM-dd-yy').parse(fechaIteracionActual.toString()) ){
            divider =  Text(fechaIteracionActual.toString());
        }

        return Column(
          children: [
            divider,
            cardContainer(test[index])
          ],
        );
      },
      
    );
  }


}
