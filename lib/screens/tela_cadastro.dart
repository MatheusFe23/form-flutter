import 'package:flutter/material.dart';

import '../models/cadastro_model.dart';
import '../validators/form_validators.dart';
import '../utils/input_formatters.dart';
import '../widgets/campo_formulario.dart';
import '../widgets/card_cadastro.dart';

/// Tela principal com o formulário de cadastro e a listagem dos registros.
///
/// Responsabilidades desta tela:
///  1. Gerenciar o estado do formulário (controllers, chave do Form).
///  2. Coordenar validação e submissão via [FormValidators].
///  3. Armazenar e exibir a lista de [CadastroModel] cadastrados.
class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  // ─── Chave global do formulário ───────────────────────────────────────────
  // Usada para acionar a validação de todos os campos de uma vez.
  final _formKey = GlobalKey<FormState>();

  // ─── Controladores de texto ───────────────────────────────────────────────
  // Cada controller captura o texto de um campo específico.
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _telefoneController = TextEditingController();

  // ─── Lista de cadastros ───────────────────────────────────────────────────
  // Armazena os dados dos usuários cadastrados para exibição na listagem.
  final List<CadastroModel> _cadastros = [];

  // ─── Ciclo de vida ────────────────────────────────────────────────────────

  @override
  void dispose() {
    // Libera os controllers da memória ao sair da tela — boa prática obrigatória.
    _nomeController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _telefoneController.dispose();
    super.dispose();
  }

  // ─── Handlers ─────────────────────────────────────────────────────────────

  /// Valida o formulário e, se aprovado, adiciona um novo [CadastroModel]
  /// à lista e limpa todos os campos para um novo preenchimento.
  void _submeterFormulario() {
    // Aciona todos os validators dos campos filhos do Form
    final formularioValido = _formKey.currentState?.validate() ?? false;

    if (!formularioValido) return; // Interrompe se houver erros

    // Cria o novo registro com os dados dos controllers
    final novoCadastro = CadastroModel(
      nome: _nomeController.text.trim(),
      email: _emailController.text.trim(),
      cpf: _cpfController.text.trim(),
      telefone: _telefoneController.text.trim(),
    );

    // Atualiza o estado para re-renderizar a lista com o novo item
    setState(() {
      _cadastros.add(novoCadastro);
    });

    // Limpa todos os campos após o cadastro bem-sucedido
    _limparFormulario();

    // Exibe feedback visual ao usuário informando o sucesso
    _exibirSnackBarSucesso();
  }

  /// Reseta todos os campos do formulário para o estado inicial.
  void _limparFormulario() {
    _formKey.currentState?.reset();
    _nomeController.clear();
    _emailController.clear();
    _cpfController.clear();
    _telefoneController.clear();

    // Limpa o estado interno dos formatadores de máscara,
    // evitando que a máscara anterior interfira no novo preenchimento.
    InputFormatters.cpf.clear();
    InputFormatters.telefone.clear();
  }

  /// Exibe um [SnackBar] de confirmação no rodapé da tela.
  void _exibirSnackBarSucesso() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Cadastro realizado com sucesso!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  // ─── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Cadastro'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Seção: Formulário ─────────────────────────────────────────
            _construirFormulario(),

            const SizedBox(height: 32),

            // ── Seção: Listagem dos cadastros ─────────────────────────────
            // Exibida apenas quando houver pelo menos um cadastro
            if (_cadastros.isNotEmpty) _construirListagem(),
          ],
        ),
      ),
    );
  }

  // ─── Construtores de seções ───────────────────────────────────────────────

  /// Constrói a seção do formulário com todos os campos e o botão de cadastro.
  Widget _construirFormulario() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Título da seção
          Text(
            'Novo Cadastro',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          // ── Campo: Nome ───────────────────────────────────────────────
          CampoFormulario(
            controller: _nomeController,
            label: 'Nome',
            hint: 'Ex.: João da Silva',
            icon: Icons.person_outline,
            validator: validarNome,
            maxLength: 150, // Limite máximo de caracteres para o nome
            textCapitalization: TextCapitalization.words, // Capitaliza cada palavra
          ),

          const SizedBox(height: 16),

          // ── Campo: E-mail ─────────────────────────────────────────────
          CampoFormulario(
            controller: _emailController,
            label: 'E-mail',
            hint: 'Ex.: joao@email.com',
            icon: Icons.email_outlined,
            validator: validarEmail,
            keyboardType: TextInputType.emailAddress, // Abre teclado de e-mail
          ),

          const SizedBox(height: 16),

          // ── Campo: CPF ────────────────────────────────────────────────
          CampoFormulario(
            controller: _cpfController,
            label: 'CPF',
            hint: '000.000.000-00',
            icon: Icons.credit_card_outlined,
            validator: validarCpf,
            keyboardType: TextInputType.number, // Abre teclado numérico
            inputFormatters: [InputFormatters.cpf], // Aplica máscara de CPF
          ),

          const SizedBox(height: 16),

          // ── Campo: Telefone ───────────────────────────────────────────
          CampoFormulario(
            controller: _telefoneController,
            label: 'Telefone',
            hint: '(00) 00000-0000',
            icon: Icons.phone_outlined,
            validator: validarTelefone,
            keyboardType: TextInputType.phone, // Abre teclado de telefone
            inputFormatters: [InputFormatters.telefone], // Aplica máscara de telefone
          ),

          const SizedBox(height: 28),

          // ── Botão de Cadastro ─────────────────────────────────────────
          ElevatedButton.icon(
            onPressed: _submeterFormulario,
            icon: const Icon(Icons.save_outlined),
            label: const Text('Cadastrar'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Constrói a seção de listagem dos cadastros realizados.
  ///
  /// Utiliza [ListView.builder] com `shrinkWrap: true` para renderizar
  /// a lista dentro de um [SingleChildScrollView] sem conflito de scroll.
  Widget _construirListagem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título da seção com contador de registros
        Text(
          'Cadastros Realizados (${_cadastros.length})',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        // Lista os cards em ordem de inserção mais recente primeiro (reversed)
        ListView.builder(
          // Necessário quando ListView está dentro de outro scrollable
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          // Exibe do mais recente para o mais antigo
          itemCount: _cadastros.length,
          itemBuilder: (context, index) {
            // Inverte a ordem para exibir o registro mais recente no topo
            final indiceInvertido = _cadastros.length - index;
            final cadastro = _cadastros[_cadastros.length - 1 - index];

            return CardCadastro(
              cadastro: cadastro,
              indice: indiceInvertido,
            );
          },
        ),
      ],
    );
  }
}
