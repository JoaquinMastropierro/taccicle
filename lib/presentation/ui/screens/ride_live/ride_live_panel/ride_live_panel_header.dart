import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:taccicle/presentation/states/bloc/live_location_bloc/live_location_bloc.dart';

class RideLivePanelHeader extends StatelessWidget {
  const RideLivePanelHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(35)),
          color: colorScheme.primary
      ),
      child: BlocBuilder<LiveLocationBloc, LiveLocationState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          if (state.status == RideStatus.initialized) {
            return headerContentInitialized();
          }

          return headerContentRiding(colorScheme);
        },
      ),
    );
  }


  Widget headerContentRiding(ColorScheme colorScheme) {
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: speedmeter(colorScheme)
        ),
        Expanded(
          child: timer()          
        )
      ],
    );
  }

  Row timer() {
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<LiveLocationBloc, LiveLocationState>(
              buildWhen: (previous, current) => previous.secondsElapsed != current.secondsElapsed,
              builder: (context, state) {
                
                final locationBloc = BlocProvider.of<LiveLocationBloc>(context);

                return Text(locationBloc.printDuration(Duration(seconds: state.secondsElapsed)), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 25));

              },
            )
          ],
        );
  }

  Widget speedmeter(ColorScheme colorScheme) {
    return BlocBuilder<LiveLocationBloc, LiveLocationState>(
      buildWhen: (previous, current) => previous.currentSpeed != current.currentSpeed,

      builder: (context, state) {

         return SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
                minimum: 0,
                maximum: 50,
                labelOffset: 20,
                ranges: [
                  GaugeRange(
                    startValue: 0,
                    endValue: 30,
                    gradient: SweepGradient(
                        colors: [colorScheme.primary, Colors.blue]),
                  ),
                  
                  GaugeRange(
                    startValue: 30,
                    endValue: 50,
                    gradient:
                        const SweepGradient(colors: [Colors.blue, Colors.red]),
                  )
                ],
                majorTickStyle: const MajorTickStyle(
                    length: 6, thickness: 4, color: Colors.white),
                minorTickStyle: const MinorTickStyle(
                    length: 3, thickness: 3, color: Colors.white),
                axisLabelStyle: const GaugeTextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
                pointers: <GaugePointer>[
                  NeedlePointer(
                    gradient: LinearGradient(
                        colors: [Colors.white, colorScheme.primary],
                        begin: Alignment(1, 0),
                        end: Alignment(1, 0.9)),
                    knobStyle: KnobStyle(knobRadius: 0),
                    value: state.currentSpeed ?? 0,
                    needleLength: 0.95,
                    enableAnimation: true,
                    animationType: AnimationType.ease,
                    needleStartWidth: 1.3,
                    needleEndWidth: 5,
                    needleColor: Color.fromARGB(255, 255, 255, 255),
                  )
                ]),
          ],
        );
       },
    );
  }

  Center headerContentInitialized() {
    return const Center(
        child: Text(
      "Toca el boton de Play para comenzar",
      style: TextStyle(
          fontSize: 19, fontWeight: FontWeight.w600, color: Colors.white),
    ));
  }
}
