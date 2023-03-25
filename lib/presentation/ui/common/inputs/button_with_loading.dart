
import 'package:flutter/material.dart';

class ButtonWithLoading extends StatefulWidget {
  const ButtonWithLoading({
    super.key,
    required this.onPress, this.height, required this.buttonContent,
  });

  final Future Function() onPress;
  final double? height;
  final Widget buttonContent; 

  @override
  State<ButtonWithLoading> createState() => _ButtonWithLoadingState();
}

class _ButtonWithLoadingState extends State<ButtonWithLoading> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(

        style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            disabledBackgroundColor: Colors.grey.withOpacity(0.7)
        ),
        onPressed: isLoading ? null : () async { 
          setState(() {
            isLoading = true;
          });

          await widget.onPress();

           setState(() {
            isLoading = false;
          });
          },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Center(
              child: buttonContent()),
        ));
  }

  Widget buttonContent() {
    if(isLoading) {
      return const SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 2,
        ),
      );
    }

    return  SizedBox(
        height: 20,
        child: widget.buttonContent
      );
  }
}