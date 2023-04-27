
import 'package:flutter/material.dart';

class ButtonWithLoading extends StatefulWidget {
  const ButtonWithLoading({
    super.key,
    required this.onPress, this.height, required this.buttonContent, this.isDisabled = false
  });

  final Future Function() onPress;
  final double? height;
  final Widget buttonContent; 
  final bool isDisabled;

  @override
  State<ButtonWithLoading> createState() => _ButtonWithLoadingState();
}

class _ButtonWithLoadingState extends State<ButtonWithLoading> {

  bool isLoading = false;
  bool isDisabled = false;

  @override
  void initState() {

   

    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
     setState(() {
      isDisabled = widget.isDisabled;
    });
    
    return TextButton(

        style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            disabledBackgroundColor: Colors.grey.withOpacity(0.7)
        ),
        onPressed: (isDisabled || isLoading) ? null : () async { 
          setState(() {
            isLoading = true;
          });
          FocusScope.of(context).requestFocus(FocusNode());

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