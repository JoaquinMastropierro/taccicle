import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CancelButton extends StatelessWidget {

  final onPressed;
  final Widget content;

  const CancelButton({super.key, this.onPressed, required this.content});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        
        style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error,
            foregroundColor: Theme.of(context).colorScheme.onError,
        ),
        onPressed: onPressed,

        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Center(
              child: content
            ),
        ));
  }
}