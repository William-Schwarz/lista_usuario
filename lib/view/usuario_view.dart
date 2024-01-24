// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lista_usuario/controller/usuario_controller.dart';
import 'package:lista_usuario/model/usuario_model.dart';
import 'package:lista_usuario/view/detalhes_usuario_view.dart';

class UsuarioView extends StatelessWidget {
  final UsuarioController _usuarioController = UsuarioController();

  UsuarioView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _usuarioController.carregarUsuarios(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Erro ao carregar usuários: ${snapshot.error}'),
          );
        } else {
          return StreamBuilder<List<UsuarioModel>>(
            stream: _usuarioController.usuariosStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<UsuarioModel> usuarios = snapshot.data!;
                return ListView.builder(
                  itemCount: usuarios.length,
                  itemBuilder: (context, index) {
                    UsuarioModel usuario = usuarios[index];
                    return ListTile(
                      title: Text(usuario.name ?? ''),
                      subtitle: Text(usuario.email ?? ''),
                      onTap: () {
                        // Adicione a navegação ou ação desejada ao tocar em um usuário
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetalhesUsuarioView(usuario: usuario),
                          ),
                        );
                      },
                    );
                  },
                );
              } else {
                return Center(
                  child: Text('Nenhum usuário encontrado.'),
                );
              }
            },
          );
        }
      },
    );
  }
}
