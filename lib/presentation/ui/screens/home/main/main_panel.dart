import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MainPanel extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

  var theme = Theme.of(context);
  var colorScheme = theme.colorScheme;
   
  Widget flexibleCard(double? height,double? width, Widget? child) {
  BoxDecoration flexibleCardDecoration(BuildContext context) {
    return BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(color: theme.shadowColor, blurRadius: 1, spreadRadius: 1)
              ],
              color: colorScheme.surface

            );
  }

    return Flexible(
            child: InkWell(
                onTap: () {},
                child: Ink(
                 decoration: flexibleCardDecoration(context),
                  height: height,
                  width: width,              
                  child: child
                ),
            ),
          );
  }

 

  Row secondRow() {
   
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            flexibleCard(250, 800,  Center(
                child: prueba()
            )),
          ],
        );
  }



  Row firtRow() {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            flexibleCard(160, 400, flexCardContent(Icon(Icons.directions_bike, color: Colors.red.withOpacity(0.7), size: 60,), "25 Km", "Distancia total recorrida")),
            SizedBox(width: 10,),
            flexibleCard(160, 400, flexCardContent(Icon(Icons.speed, color: Colors.green.withOpacity(0.55), size: 60,), "14 Km/h", "Velocidad promedio")),

          ],
        );
  }


    return Container(
      padding: EdgeInsets.all(10.0),
      child: ListView(
        children: [
          const SizedBox( height:  25),
          firtRow(),
          const SizedBox( height:  15,),
          secondRow(),
          const SizedBox( height:  25),
          firtRow(),
          
       
        ],
      ),
    );

    
  }

  Column flexCardContent(Icon icon, String textoCentral, String textoInferior) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
          const Spacer(),
          icon,
          Text(textoCentral,  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
          const Spacer(),
          Text(textoInferior, style: const TextStyle( fontSize: 12 )),
          const SizedBox(height: 5,)
      ],
    );
  }

  


  prueba(){
    return Center(
        child: Container(
          child: SfCartesianChart(
            // Initialize category axis
            primaryXAxis: CategoryAxis(
              axisLine: const AxisLine(width: 0),
              majorGridLines: MajorGridLines(width: 0), 

            ),
        
            title: ChartTitle(text: "Kms recorridos en los ultimos meses", alignment: ChartAlignment.near, textStyle: TextStyle(fontSize: 12)),
            series: <LineSeries<SalesData, String>>[
              LineSeries<SalesData, String>(
                
                // Bind data source
                dataSource:  <SalesData>[
                  SalesData('Jan', 35),
                  SalesData('Feb', 28),
                  SalesData('Mar', 29),
                  SalesData('Apr', 32),
                  SalesData('Jan', 1),
                ],
                xValueMapper: (SalesData sales, _) => sales.year,
                yValueMapper: (SalesData sales, _) => sales.sales
              )
            ]
          )
        )
      );
  }

}




class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
