import 'package:flutter/material.dart';
import 'package:projeto_estoico/app/utils/custom_color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;

  const CustomAppBar({super.key, this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: CustomColor.backgroundColor, // Cor de fundo da AppBar
      elevation: 0, // Remove a sombra abaixo da AppBar
      leading: Padding(
        padding: const EdgeInsets.only(top: 8, left: 4, bottom: 8),
        child: Image.asset(
          'assets/image/logo.png',
          height: 32,
          width: 30,
        ),
      ),
      title: Text(title ?? ''),
      actions: actions ?? [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Define o tamanho da AppBar
}
