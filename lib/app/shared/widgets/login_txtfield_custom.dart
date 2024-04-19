import 'package:flutter/material.dart';
import 'package:projeto_estoico/app/utils/color_custom.dart';
import 'package:projeto_estoico/app/utils/font_custom.dart';

class LoginTextFieldCustom extends StatelessWidget {
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final String? label;
  final IconData? icon;
  final TextEditingController? controller;

  const LoginTextFieldCustom({
    super.key,
    this.validator,
    this.onSaved,
    this.label,
    this.icon,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onSaved: onSaved,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: FontCustom.montserratRegular(15).copyWith(color: ColorCustom.pretoFonte),
        contentPadding: const EdgeInsets.only(left: 20, bottom: 30),
        suffixIcon: icon == null
            ? null
            : Icon(
                icon,
                color: Colors.black,
                size: 18,
              ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorCustom.pretoBorda, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorCustom.pretoBorda, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorCustom.verde500, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorCustom.verde500, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
