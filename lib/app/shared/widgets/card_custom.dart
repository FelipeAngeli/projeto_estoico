import 'package:flutter/material.dart';
import 'package:projeto_estoico/app/utils/color_custom.dart';

class CardCustom extends StatelessWidget {
  final String frase;
  final String autor;
  const CardCustom({super.key, required this.frase, required this.autor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorCustom.verde,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
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
      ),
    );
  }
}
