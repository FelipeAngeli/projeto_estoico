import 'package:flutter/material.dart';
import 'package:projeto_estoico/app/utils/custom_color.dart';

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
          color: CustomColor.verde,
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
