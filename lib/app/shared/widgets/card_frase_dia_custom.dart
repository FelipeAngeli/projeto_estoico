import 'package:flutter/material.dart';
import 'package:projeto_estoico/app/utils/color_custom.dart';

class CardFraseDiaCustom extends StatelessWidget {
  final String frase;
  final String autor;
  const CardFraseDiaCustom({super.key, required this.frase, required this.autor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Image(
          image: AssetImage('assets/image/seneca.png'),
        ),
        const SizedBox(height: 16),
        const Image(
          image: AssetImage('assets/image/folha.png'),
        ),
        const SizedBox(height: 16),
        Text(
          frase,
          style: TextStyle(
            color: ColorCustom.preto,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            autor,
            style: TextStyle(
              color: ColorCustom.preto,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
