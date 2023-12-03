import 'package:desafio_6_etapa/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/theme.g.dart';

class LoginContent extends StatefulWidget {
  const LoginContent({Key? key}) : super(key: key);

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LoginController(),
        builder: (context, child) {
          return Consumer<LoginController>(
              builder: (context, controller, child) {
            return Scaffold(
              body: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/login_background.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Form(
                            key: controller.state.formKey,
                            child: Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 32, horizontal: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 64),
                                    Text('Identificação',
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: lightColorScheme.primary,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 48),
                                    TextFormField(
                                      controller:
                                          controller.state.emailController,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'E-mail',
                                          suffixIcon: Icon(Icons.person)),
                                      validator: controller.validateEmail,
                                    ),
                                    const SizedBox(height: 16),
                                    TextFormField(
                                      controller:
                                          controller.state.senhaController,
                                      obscureText:
                                          !controller.state.showPassword,
                                      decoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        labelText: 'Senha',
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            controller.state.showPassword
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                          ),
                                          onPressed: controller
                                              .alterarVisibilidadeSenha,
                                        ),
                                      ),
                                      validator: controller.validatePassword,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                          onPressed: () => {},
                                          child: const Text(
                                              'ESQUECI MINHA SENHA')),
                                    ),
                                    const SizedBox(height: 32),
                                    FilledButton(
                                        onPressed: () {
                                          controller.logar(context,
                                              controller.state.formKey);
                                        },
                                        child: const Text('Entrar')),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/logo1.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          });
        });
  }
}
