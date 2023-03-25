import 'package:flutter/material.dart';

class CustomShadowedInput extends StatelessWidget {
   final String? hintText;
   final String? Function(String?)? validation;
   final Function(String?)? onChange;
   final bool obscureText;

    const CustomShadowedInput({
    super.key,
    this.hintText, 
    this.validation, 
    this.onChange,
    this.obscureText = false
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding:const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(blurRadius: 15, spreadRadius: 0.07, color: theme.shadowColor)]
      ),
      child: TextFormField(   
        onChanged: onChange,
        validator: validation, 
        obscureText: obscureText,                          
        decoration: InputDecoration(
          border: InputBorder.none,       
          hintText: hintText,                                   
        ),
      ),
    );
  }
}