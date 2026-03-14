import 'package:flutter/material.dart';
import 'screens/tela_cadastro.dart';

/// Ponto de entrada da aplicação.
///
/// Define o tema global e aponta para a tela inicial [TelaCadastro].
void main() {
  runApp(const MeuApp());
}

/// Widget raiz da aplicação.
///
/// Responsável por configurar o [MaterialApp] com o tema e a rota inicial.
class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove o banner "DEBUG" do canto superior direito
      debugShowCheckedModeBanner: false,

      title: 'Formulário de Cadastro',

      // ── Configuração do tema ─────────────────────────────────────────────
      theme: ThemeData(
        // Esquema de cores baseado em azul/índigo para visual moderno
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.light,
        ),
        // Habilita componentes Material 3 (estética moderna)
        useMaterial3: true,
        // Estilo padrão dos botões elevados — herda cor primária do esquema
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
          ),
        ),
      ),

      // Tela inicial da aplicação
      home: const TelaCadastro(),
    );
  }
}
