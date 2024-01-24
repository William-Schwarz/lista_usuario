import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:lista_usuario/model/usuario_model.dart';

class UsuarioController {
  final _usuariosController = StreamController<List<UsuarioModel>>();
  Stream<List<UsuarioModel>> get usuariosStream => _usuariosController.stream;

  List<UsuarioModel> _usuarios = [];

  Future<void> carregarUsuarios() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

      if (response.statusCode == 200) {
        List<dynamic> jsonUsuarios = jsonDecode(response.body);
        _usuarios =
            jsonUsuarios.map((json) => UsuarioModel.fromJson(json)).toList();
        _usuariosController.add(_usuarios);
      } else {
        throw Exception('Erro ao carregar usuários');
      }
    } catch (e) {
      throw Exception('Erro ao carregar usuários: $e');
    }
  }

  void dispose() {
    _usuariosController.close();
  }
}

// Exemplo de uso da classe UsuarioController
void exemploUsuarioController() async {
  final usuarioController = UsuarioController();

  try {
    await usuarioController.carregarUsuarios();

    usuarioController.usuariosStream.listen((usuarios) {
      if (kDebugMode) {
        print('Número de usuários: ${usuarios.length}');
      }
    });
  } catch (e) {
    if (kDebugMode) {
      print('Erro: $e');
    }
  } finally {
    usuarioController.dispose();
  }
}
