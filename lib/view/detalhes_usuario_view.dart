import 'package:flutter/material.dart';
import 'package:lista_usuario/model/usuario_model.dart';

class DetalhesUsuarioView extends StatelessWidget {
  final UsuarioModel usuario;

  const DetalhesUsuarioView({Key? key, required this.usuario})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome: ${usuario.name ?? 'N/A'}'),
            Text('Email: ${usuario.email ?? 'N/A'}'),
            // Adicione mais detalhes conforme necessário
          ],
        ),
      ),
    );
  }
}
