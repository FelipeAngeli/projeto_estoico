import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/app_module.dart';
import 'package:projeto_estoico/app/app_widget.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Garante a inicialização dos bindings
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Necessário para inicialização do Firebase
  );
  runApp(ModularApp(
    module: AppModule(),
    child: const AppWidget(),
  ));
}
