import 'package:flutter/material.dart';
import 'package:projeto_estoico/app/utils/color_custom.dart';

class BtnLoginCustom extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Color? backgroundColor;
  const BtnLoginCustom({super.key, this.onPressed, required this.text, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? ColorCustom.verde,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          shadowColor: ColorCustom.verde,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
          child: Text(
            text,
            style: const TextStyle(fontSize: 20, color: Color(0xFFFFFFFF)),
          ),
        ));
  }
}
