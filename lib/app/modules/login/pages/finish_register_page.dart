import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/core/ui/base_state/base_state.dart';
import 'package:projeto_estoico/app/modules/login/cubit/profile/auth_cubit.dart';
import 'package:projeto_estoico/app/shared/widgets/button_custom.dart';
import 'package:projeto_estoico/app/utils/color_custom.dart';
import 'package:projeto_estoico/app/utils/font_custom.dart';

class FinishRegisterpage extends StatefulWidget {
  const FinishRegisterpage({super.key});

  @override
  State<FinishRegisterpage> createState() => _FinishRegisterpageState();
}

class _FinishRegisterpageState extends BaseState<FinishRegisterpage, AuthCubit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              ButtonCustom(
                type: CustomButtonType.elevated,
                width: double.infinity,
                height: 36,
                onPressed: () {
                  Modular.to.pushNamed('/fraseDia');
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: ColorCustom.verde500,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                child: controller.state is AuthLoadingState
                    ? const CircularProgressIndicator.adaptive()
                    : Text(
                        'Finalizar',
                        style: FontCustom.montserratBold16.copyWith(color: Colors.white),
                      ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
