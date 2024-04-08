import 'package:flutter/material.dart';
import 'package:projeto_estoico/app/utils/custom_color.dart';

class CardFraseDiaCustom extends StatelessWidget {
  final String frase;
  final String autor;
  const CardFraseDiaCustom({super.key, required this.frase, required this.autor});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image(
            image: AssetImage('assets/image/seneca.png'),
          ),
          SizedBox(height: 16),
          Image(
            image: AssetImage('assets/image/folha.png'),
          ),
          SizedBox(height: 16),
          Text(
            frase,
            style: TextStyle(
              color: CustomColor.preto,
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
                color: CustomColor.preto,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
