import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

class AddEducatorPage extends StatefulWidget {
  final SupabaseClient supabaseClient;

  // Recebe o cliente Supabase como parâmetro
  AddEducatorPage({required this.supabaseClient});

  @override
  _AddEducatorPageState createState() => _AddEducatorPageState();
}

class _AddEducatorPageState extends State<AddEducatorPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  // Função para adicionar um novo educador no Supabase
  Future<void> _addEducator() async {
    final response = await widget.supabaseClient.from('educators').insert({
      'nome_completo': _nameController.text,  // Nome do educador
      'email': _emailController.text,         // Email do educador
    }).execute();

    if (response.error == null) {
      // Se a inserção for bem-sucedida, volta para a tela anterior
      Navigator.of(context).pop();
    } else {
      // Exibe mensagem de erro, caso ocorra algum problema
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro: ${response.error!.message}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Adicionar Educador")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Nome Completo"),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addEducator,  // Chama a função para adicionar educador
              child: Text("Adicionar"),
            ),
          ],
        ),
      ),
    );
  }
}
