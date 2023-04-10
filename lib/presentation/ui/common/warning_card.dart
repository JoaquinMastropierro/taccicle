import 'package:flutter/material.dart';

class WarningCard extends StatelessWidget {
  
  final String text;
  final void Function()? action;

  const WarningCard({
    super.key, required this.text,  this.action,
  });


  @override
  Widget build(BuildContext context) {

    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;


    return InkWell(
      onTap: action,
      child: Ink(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.deepOrange,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: theme.shadowColor, blurRadius: 1, spreadRadius: 1)
          ],
        ),
        height: 65,
        child:  Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600,)
        ),
      ),
    );
  }
}
