import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontCustom {
  static TextStyle montserratLight(double size, [Color? color]) {
    return GoogleFonts.montserrat(fontSize: size, fontWeight: FontWeight.w300, color: color);
  }

  static TextStyle montserratRegular(double size, [Color? color]) {
    return GoogleFonts.montserrat(fontSize: size, fontWeight: FontWeight.w400, color: color);
  }

  static TextStyle montserratMedium(double size, [Color? color]) {
    return GoogleFonts.montserrat(fontSize: size, fontWeight: FontWeight.w500, color: color);
  }

  static TextStyle montserratSemiBold(double size, [Color? color]) {
    return GoogleFonts.montserrat(fontSize: size, fontWeight: FontWeight.w600, color: color);
  }

  static TextStyle montserratBold(double size, [Color? color]) {
    return GoogleFonts.montserrat(fontSize: size, fontWeight: FontWeight.w700, color: color);
  }

  // Exemplos de métodos para múltiplos de 8 até 64
  static TextStyle get montserratLight8 => montserratLight(8);
  static TextStyle get montserratLight16 => montserratLight(16);
  static TextStyle get montserratLight24 => montserratLight(24);
  static TextStyle get montserratLight32 => montserratLight(32);
  static TextStyle get montserratLight48 => montserratLight(48);
  static TextStyle get montserratLight64 => montserratLight(64);

  static TextStyle get montserratRegular8 => montserratRegular(8);
  static TextStyle get montserratRegular16 => montserratRegular(16);
  static TextStyle get montserratRegular24 => montserratRegular(24);
  static TextStyle get montserratRegular32 => montserratRegular(32);
  static TextStyle get montserratRegular48 => montserratRegular(48);
  static TextStyle get montserratRegular64 => montserratRegular(64);

  static TextStyle get montserratMedium8 => montserratMedium(8);
  static TextStyle get montserratMedium16 => montserratMedium(16);
  static TextStyle get montserratMedium24 => montserratMedium(24);
  static TextStyle get montserratMedium32 => montserratMedium(32);
  static TextStyle get montserratMedium48 => montserratMedium(48);
  static TextStyle get montserratMedium64 => montserratMedium(64);

  static TextStyle get montserratSemiBold8 => montserratSemiBold(8);
  static TextStyle get montserratSemiBold16 => montserratSemiBold(16);
  static TextStyle get montserratSemiBold24 => montserratSemiBold(24);
  static TextStyle get montserratSemiBold32 => montserratSemiBold(32);
  static TextStyle get montserratSemiBold48 => montserratSemiBold(48);
  static TextStyle get montserratSemiBold64 => montserratSemiBold(64);

  static TextStyle get montserratBold8 => montserratBold(8);
  static TextStyle get montserratBold16 => montserratBold(16);
  static TextStyle get montserratBold24 => montserratBold(24);
  static TextStyle get montserratBold32 => montserratBold(32);
  static TextStyle get montserratBold48 => montserratBold(48);
  static TextStyle get montserratBold64 => montserratBold(64);
}
