import 'package:flutter/material.dart';
import 'package:projeto_estoico/app/utils/custom_color.dart';

class PasswordFieldWidger extends StatefulWidget {
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final String? label;
  const PasswordFieldWidger({
    super.key,
    this.onSaved,
    this.validator,
    this.label,
  });

  @override
  State<PasswordFieldWidger> createState() => _PasswordFieldWidgerState();
}

class _PasswordFieldWidgerState extends State<PasswordFieldWidger> {
  bool _isObscure = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: widget.onSaved,
      obscureText: _isObscure,
      validator: widget.validator,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: const TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
        contentPadding: const EdgeInsets.only(left: 20, bottom: 30),
        suffixIcon: IconButton(
            icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
            color: Colors.black,
            iconSize: 18,
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            }),
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
