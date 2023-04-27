import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:taccicle/domain/entities/HistoryRideItem.dart';

class HistoryListScreen extends StatelessWidget {
  HistoryListScreen({super.key});

  final test = [
     HistoryRideItem("32", "3 Horas 2 minutos", DateTime.now(), 3, "Jerepepe",const Color.fromARGB(255, 107, 1, 255), Colors.white.withOpacity(0.90)),
     HistoryRideItem("12", "1 Horas 12 minutos", DateTime(2023, 4, 15, 15, 1, 22), 1, "Jere", Color.fromARGB(255, 180, 96, 96), Colors.white.withOpacity(0.90)),
     HistoryRideItem("15", "1 Horas 33 minutos", DateTime(2023, 3, 15, 15, 2, 22), 1, "Jere", const Color(0xF5F3C100), Colors.black54),
     HistoryRideItem("32", "3 Horas 2 minutos", DateTime(2023, 2, 13, 15, 3, 22), 3, "Jerepepe",const Color.fromARGB(255, 107, 1, 255), Colors.white.withOpacity(0.90)),
     HistoryRideItem("12", "1 Horas 12 minutos", DateTime(2023, 2, 13, 15, 4, 22), 1, "Jere", const Color.fromARGB(255, 39, 225, 194), Colors.black54),
     HistoryRideItem("15", "1 Horas 33 minutos", DateTime(2023, 1, 11, 15, 5, 22), 1, "Jere", const Color.fromARGB(255, 25, 54, 109), Colors.white.withOpacity(0.90)),
  ];

  final Days = [
    "no se usa",
    "Lun",
    "Mar",
    "Mier",
    "Juev",
    "Vier",
    "Sab",
    "Dom"
  ];

    final Months = [
    "no se usa",
    "Enero",
    "Febrero",
    "Marzo",
    "Abril",
    "Mayo",
    "Junio",
    "Julio",
    "Agosto",
    "Septiembre",
    "Octubre",
    "Noviembre",
    "Diciembre"
  ];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;

    BoxDecoration cardDecoration(HistoryRideItem salida) {
      return  BoxDecoration(
          //color: salida.colorSalida,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          gradient: LinearGradient(
            colors: [salida.colorSalida!, salida.colorSalida!.withOpacity(0.6) , salida.colorSalida! ],
                    begin: const FractionalOffset(0, 0),
                    end: const FractionalOffset(1, 1),
                    stops: [0.0, 0.5, 1],
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

    InkWell historyCard(HistoryRideItem salida) {
      String hora = DateFormat("hh:mm").format(salida.HoraInicio);

      return InkWell(
        onTap: () {
          
        },
        child: Ink(
          decoration: cardDecoration(salida),
          height: 120,
          child: Stack(
            children: [
              Positioned(child: Icon(Icons.directions_bike_outlined, size: 80, color: Colors.white.withOpacity(0.2),), bottom: 0, right:5,),
              Container(
                padding: const EdgeInsets.all(15),
                child: CardContent(hora, salida),
              ),
            ],
          )
        ),
      );
  }
    
    return ListView.builder(
      
      itemCount: test.length,
      itemBuilder: (BuildContext context, int index) {

        var lastDate = index == 0 ? null : test[index-1].HoraInicio;
        var currentIterationDate = test[index].HoraInicio;

        Widget divider = const SizedBox();


        currentIterationDate = DateFormat('MM-dd-yy').parse(currentIterationDate.toString());
        
        // this condition means that the day has changed, so we put a Divider with de Date
        if(lastDate == null || DateFormat('MM-dd-yy').parse(lastDate.toString()) != currentIterationDate){
          
          var cardsOnCurrentDay = test.where((e)=> (DateFormat('MM-dd-yy').parse(e.HoraInicio.toString()) == currentIterationDate)).toList();
          
          
          divider = buildDivider(currentIterationDate, cardsOnCurrentDay);
            
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              divider,
              historyCard(test[index]),
              const SizedBox(height: 15)
            ],
          ),
        );
      },
      
    );

    
  }




  Padding buildDivider(DateTime currentIterationDate, List<HistoryRideItem> cardOnDay) {



    return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text( "${ Days[currentIterationDate.weekday]} ${currentIterationDate.day.toString()} de ${Months[currentIterationDate.month]}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w400, 
                        fontSize: 16
                      ),
                ),
                if(cardOnDay.length > 1) 
                  ... [const Spacer(), calculateDistance(cardOnDay)]
              ],
            ),
          );
  }

  Text calculateDistance(List<HistoryRideItem> cardOnDay){

      int acumulatedDistance = cardOnDay
      .map((value) => int.parse(value.distancia))
      .reduce((value, element) => value + element);

      return Text("$acumulatedDistance Km");
  }

  Column CardContent(String hora, HistoryRideItem salida) {
    return Column(
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
                    Text("${salida.distancia} Km", style: TextStyle(color: salida.colorSalidaAscent, fontSize: 18),)
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
        );
  }


}
