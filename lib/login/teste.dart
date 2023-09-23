import 'package:desafio_6_etapa/theme/theme.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Teste extends StatelessWidget {
  final TextEditingController _emailController;
  final TextEditingController _senhaController;
  final bool _mostrarSenha;

  const Teste(this._emailController, this._senhaController, this._mostrarSenha,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 32, horizontal: 32),
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
                          labelText: 'E-mail',
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
                          labelText: 'Senha',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _mostrarSenha
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () => {},
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
                            child: Text('ESQUECI MINHA SENHA')),
                      ),
                      const SizedBox(height: 32),
                      FilledButton(onPressed: () => {}, child: Text('Entrar')),
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
    );
  }
}
