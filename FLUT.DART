import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'educators_page.dart';

class LoginPage extends StatefulWidget {
  final SupabaseClient supabaseClient;

  // Recebe o cliente Supabase como parâmetro
  LoginPage({required this.supabaseClient});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Função de login com Supabase
  Future<void> _login() async {
    // Realiza a tentativa de login
    final response = await widget.supabaseClient.auth.signIn(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (response.error == null) {
      // Se o login for bem-sucedido, navega para a página de educadores
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => EducatorsPage(supabaseClient: widget.supabaseClient),
        ),
      );
    } else {
      // Caso ocorra um erro, exibe uma mensagem para o usuário
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.error!.message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: "Senha"),
              obscureText: true,  // Esconde a senha enquanto o usuário digita
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,  // Chama a função de login
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
