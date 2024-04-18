import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/utils/color_custom.dart';
import 'package:projeto_estoico/app/utils/font_custom.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 3));

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Modular.to.pushNamed('/login');
      } else {
        Modular.to.pushReplacementNamed('/fraseDia');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorCustom.backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 157,
                height: 165,
                child: Image(
                  image: AssetImage('assets/image/logo.png'),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Estoicismo Diário",
                style: FontCustom.montserratSemiBold16.copyWith(color: ColorCustom.pretoFonte),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
