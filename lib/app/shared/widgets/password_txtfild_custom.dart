import 'package:flutter/material.dart';
import 'package:projeto_estoico/app/utils/color_custom.dart';

class PasswordFieldWidger extends StatefulWidget {
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final String? label;
  final TextEditingController? controller;
  const PasswordFieldWidger({
    super.key,
    this.onSaved,
    this.validator,
    this.label,
    this.controller,
  });

  @override
  State<PasswordFieldWidger> createState() => _PasswordFieldWidgerState();
}

class _PasswordFieldWidgerState extends State<PasswordFieldWidger> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onSaved: widget.onSaved,
      obscureText: _isObscure,
      validator: widget.validator,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          fontSize: 15,
          color: ColorCustom.pretoFonte,
        ),
        contentPadding: const EdgeInsets.only(left: 20, bottom: 30),
        suffixIcon: IconButton(
            icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
            color: ColorCustom.pretoFonte,
            iconSize: 18,
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            }),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorCustom.pretoBorda, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorCustom.pretoBorda, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
