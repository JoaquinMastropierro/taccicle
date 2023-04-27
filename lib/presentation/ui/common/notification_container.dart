import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:taccicle/presentation/states/providers/location_provider.dart';
import 'package:taccicle/presentation/ui/common/warning_card.dart';

class NotificationContainer extends StatelessWidget {
  const NotificationContainer({super.key});

  @override
  Widget build(BuildContext context) {

    final locationProvider = Provider.of<LocationProvider>(context);


    return Column(
      children: [
        if(!locationProvider.isLocationActivated) 
          const WarningCard(
            text: "La ubicacion se encuentra desactivada, se importante activarla para poder registrar salidas correctamente",          
          ),

        if(!locationProvider.isPermissonEnabled && !locationProvider.isLocationActivated)
          const SizedBox(   
            height: 10,
          ),

        if(!locationProvider.isPermissonEnabled) 
          WarningCard(
            text: "La aplicacion no tiene permiso para usar la localizacion, toque aqui para dar permisos.", 
            action: () => locationProvider.changePermission()
          ),

        if(!locationProvider.isPermissonEnabled || !locationProvider.isLocationActivated) const SizedBox(height: 15)
      ],
    );
  }
}