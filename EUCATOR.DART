import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'add_educator_page.dart';

class EducatorsPage extends StatefulWidget {
  final SupabaseClient supabaseClient;

  // Recebe o cliente Supabase como parâmetro
  EducatorsPage({required this.supabaseClient});

  @override
  _EducatorsPageState createState() => _EducatorsPageState();
}

class _EducatorsPageState extends State<EducatorsPage> {
  List<dynamic> _educators = [];  // Lista que armazenará os educadores

  @override
  void initState() {
    super.initState();
    _fetchEducators();  // Chama a função para buscar educadores ao iniciar a tela
  }

  // Função para buscar os educadores do Supabase
  Future<void> _fetchEducators() async {
    final response = await widget.supabaseClient
        .from('educators')  // Nome da tabela no Supabase
        .select()            // Consulta para selecionar todos os dados
        .execute();

    setState(() {
      _educators = response.data as List<dynamic>;  // Armazena os dados na lista
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Educadores"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _fetchEducators,  // Atualiza a lista de educadores
          ),
        ],
      ),
      // Exibe a lista de educadores usando ListView
      body: ListView.builder(
        itemCount: _educators.length,
        itemBuilder: (context, index) {
          final educator = _educators[index];
          return ListTile(
            title: Text(educator['nome_completo']),  // Nome do educador
            subtitle: Text(educator['email']),        // Email do educador
          );
        },
      ),
      // Botão para adicionar um novo educador
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) =>
                  AddEducatorPage(supabaseClient: widget.supabaseClient),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
