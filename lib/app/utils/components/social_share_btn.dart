import 'package:flutter/material.dart';
import 'package:projeto_estoico/app/utils/custom_color.dart';
import 'package:share_plus/share_plus.dart';

class SocialShareButton extends StatelessWidget {
  final String textToShare;

  const SocialShareButton({Key? key, required this.textToShare}) : super(key: key);

  void _shareContent(BuildContext context, String platform) {
    // Fechar o modal
    Navigator.of(context).pop();
    // Compartilhar o conteúdo
    Share.share(textToShare);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.share, color: CustomColor.verde),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Compartilhe a frase'),
              content: SingleChildScrollView(
                child: Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Image.asset('assets/icones/whatsapp.png', height: 24),
                      onPressed: () => _shareContent(context, "WhatsApp"),
                    ),
                    IconButton(
                      icon: Image.asset('assets/icones/instagram.png', height: 24),
                      onPressed: () => _shareContent(context, "Instagram"),
                    ),
                    IconButton(
                      icon: Image.asset('assets/icones/facebook.png', height: 24),
                      onPressed: () => _shareContent(context, "Facebook"),
                    ),
                    IconButton(
                      icon: Image.asset('assets/icones/twitter.png', height: 24),
                      onPressed: () => _shareContent(context, "Twitter"),
                    ),
                    IconButton(
                      icon: Image.asset('assets/icones/tinder.png', height: 24),
                      onPressed: () => _shareContent(context, "Tinder"),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: Text(
                    'Fechar',
                    style: TextStyle(color: CustomColor.verde),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
