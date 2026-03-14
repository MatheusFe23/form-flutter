import 'package:flutter/material.dart';
import '../models/cadastro_model.dart';

/// Card reutilizável que exibe os dados de um único [CadastroModel].
///
/// Mostra cada campo com seu respectivo ícone e rótulo,
/// mantendo uma formatação visual consistente na listagem.
class CardCadastro extends StatelessWidget {
  // ─── Parâmetros ───────────────────────────────────────────────────────────

  /// Dados do cadastro a serem exibidos.
  final CadastroModel cadastro;

  /// Posição do item na lista (exibida no cabeçalho do card).
  final int indice;

  // ─── Construtor ───────────────────────────────────────────────────────────

  const CardCadastro({
    super.key,
    required this.cadastro,
    required this.indice,
  });

  // ─── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      // Elevação sutil para dar profundidade ao card
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Cabeçalho do card com número do registro ─────────────────
            Row(
              children: [
                Icon(Icons.person, color: colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Cadastro #$indice',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),

            const Divider(height: 20),

            // ── Linha: Nome ───────────────────────────────────────────────
            _LinhaInfo(
              icone: Icons.badge_outlined,
              rotulo: 'Nome',
              valor: cadastro.nome,
            ),

            const SizedBox(height: 8),

            // ── Linha: E-mail ─────────────────────────────────────────────
            _LinhaInfo(
              icone: Icons.email_outlined,
              rotulo: 'E-mail',
              valor: cadastro.email,
            ),

            const SizedBox(height: 8),

            // ── Linha: CPF ────────────────────────────────────────────────
            _LinhaInfo(
              icone: Icons.credit_card_outlined,
              rotulo: 'CPF',
              valor: cadastro.cpf,
            ),

            const SizedBox(height: 8),

            // ── Linha: Telefone ───────────────────────────────────────────
            _LinhaInfo(
              icone: Icons.phone_outlined,
              rotulo: 'Telefone',
              valor: cadastro.telefone,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Widget interno: linha de informações ─────────────────────────────────────

/// Widget privado que exibe uma linha de informação com ícone, rótulo e valor.
///
/// Usado internamente pelo [CardCadastro] para padronizar a
/// exibição de cada campo sem repetição de código.
class _LinhaInfo extends StatelessWidget {
  /// Ícone que identifica o tipo de dado.
  final IconData icone;

  /// Rótulo do campo (ex.: "Nome", "CPF").
  final String rotulo;

  /// Valor a ser exibido.
  final String valor;

  const _LinhaInfo({
    required this.icone,
    required this.rotulo,
    required this.valor,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Ícone identificador
        Icon(icone, size: 18, color: Colors.grey.shade600),
        const SizedBox(width: 8),

        // Rótulo em negrito
        Text(
          '$rotulo: ',
          style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ),

        // Valor — usa Expanded para quebrar linha em textos longos
        Expanded(
          child: Text(
            valor,
            style: textTheme.bodyMedium,
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
