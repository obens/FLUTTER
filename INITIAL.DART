import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'login_page.dart';
import 'educators_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Configura o cliente Supabase com a URL e a chave pública
  final supabaseClient = SupabaseClient(
    'YOUR_SUPABASE_URL',       // Substitua pela URL do Supabase
    'YOUR_SUPABASE_ANON_KEY',  // Substitua pela chave anônima do Supabase
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,  // Define o tema principal
      ),
      // Define a tela inicial como a página de login
      home: LoginPage(supabaseClient: supabaseClient),
    );
  }
}
