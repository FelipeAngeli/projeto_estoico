import 'package:flutter/material.dart';
import 'package:projeto_estoico/app/utils/custom_color.dart';

class LoginTextFieldCustom extends StatelessWidget {
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final String? label;
  final IconData? icon;
  const LoginTextFieldCustom({super.key, this.validator, this.onSaved, this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onSaved: onSaved,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: const EdgeInsets.only(left: 20, bottom: 30),
        suffixIcon: icon == null
            ? null
            : Icon(
                icon,
                color: Colors.black,
                size: 18,
              ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: CustomColor.verde, width: 1.75),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: CustomColor.verde, width: 1.75),
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.75),
          borderRadius: BorderRadius.circular(28),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.75),
          borderRadius: BorderRadius.circular(28),
        ),
      ),
    );
  }
}
