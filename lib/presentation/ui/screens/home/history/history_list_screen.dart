import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

class HistoryListScreen extends StatelessWidget {
  HistoryListScreen({super.key});

  final test = [
    {
      "creador":"Jeremias",
      "fecha": DateTime.now(),
      "participantes":3,
      "kilometros":32,
      "duracion": "3 Horas 15 minutos",
      
    },
    {
      "creador":"Jeremias",
      "fecha": DateTime.now(),
      "participantes":3,
      "kilometros":32,
    }
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: test.length,
      itemBuilder: (BuildContext context, int index) {

        Map item = test[index];

        DateTime fecha = item['fecha'];
        String hora = DateFormat("hh:mm").format(fecha);
        
        return Padding(

          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(10)),            
            ),
            padding: EdgeInsets.all(5),
            height: 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(hora)
              ],
            ),
          ),
        );


      },
    );
  }
}