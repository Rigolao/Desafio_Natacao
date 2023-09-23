import 'package:desafio_6_etapa/home/home_content.dart';
import 'package:desafio_6_etapa/login/teste.dart';
import 'package:flutter/material.dart';

import '../theme/theme.g.dart';

class LoginContent extends StatefulWidget {
  const LoginContent({Key? key}) : super(key: key);

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _mostrarSenha = false;

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  void _alterarVisibilidadeSenha() {
    setState(() {
      _mostrarSenha = !_mostrarSenha;
    });
  }

  void _logar() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(context, '/home');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login realizado')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Material(
      child: Stack(
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
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Container(
                      padding:
                      const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
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
                              style: TextStyle(fontSize: 24, color: lightColorScheme.primary, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 48),
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'E-mail',
                              suffixIcon: Icon(Icons.person)
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Coloque seu email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _senhaController,
                            obscureText: !_mostrarSenha,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Senha',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _mostrarSenha
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: _alterarVisibilidadeSenha,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Coloque sua senha';
                              }
                              return null;
                            },
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () => {},
                                child: const Text('ESQUECI MINHA SENHA')),
                          ),
                          const SizedBox(height: 32),
                          FilledButton(onPressed: () => {}, child: const Text('Entrar')),
                        ],
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
  }
}