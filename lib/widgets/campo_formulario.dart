import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Widget reutilizável de campo de texto para formulários.
///
/// Encapsula o [TextFormField] com estilo padronizado, reduzindo
/// duplicação de código nas telas que utilizam campos de entrada.
///
/// Parâmetros obrigatórios:
/// - [controller]: controlador do texto.
/// - [label]: texto do rótulo exibido dentro do campo.
/// - [hint]: texto de placeholder exibido quando o campo está vazio.
/// - [validator]: função de validação do valor digitado.
///
/// Parâmetros opcionais:
/// - [keyboardType]: tipo de teclado a ser exibido.
/// - [inputFormatters]: lista de formatadores (ex.: máscaras).
/// - [maxLength]: limite máximo de caracteres.
/// - [textCapitalization]: capitalização automática do texto.
class CampoFormulario extends StatelessWidget {
  // ─── Parâmetros ───────────────────────────────────────────────────────────

  /// Controlador do campo de texto.
  final TextEditingController controller;

  /// Texto do rótulo/label do campo.
  final String label;

  /// Texto de placeholder exibido quando o campo está vazio.
  final String hint;

  /// Ícone exibido à esquerda do campo (prefixo).
  final IconData icon;

  /// Função de validação — deve retornar mensagem de erro ou null se válido.
  final String? Function(String?) validator;

  /// Tipo de teclado a ser aberto (padrão: texto).
  final TextInputType keyboardType;

  /// Formatadores de entrada (ex.: máscaras de CPF, telefone).
  final List<TextInputFormatter>? inputFormatters;

  /// Número máximo de caracteres permitidos no campo.
  final int? maxLength;

  /// Define a capitalização automática do texto digitado.
  final TextCapitalization textCapitalization;

  // ─── Construtor ───────────────────────────────────────────────────────────

  const CampoFormulario({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.maxLength,
    this.textCapitalization = TextCapitalization.none,
  });

  // ─── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      textCapitalization: textCapitalization,
      validator: validator,
      // Oculta o contador de caracteres padrão quando maxLength é definido,
      // pois ele será exibido somente se o campo atingir o limite.
      buildCounter:
          maxLength != null
              ? (
                context, {
                required currentLength,
                required isFocused,
                maxLength,
              }) => Text(
                '$currentLength / $maxLength',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color:
                      currentLength == maxLength ? Colors.redAccent : Colors.grey,
                ),
              )
              : null,
      decoration: InputDecoration(
        // Rótulo do campo
        labelText: label,
        // Placeholder / dica de preenchimento
        hintText: hint,
        // Ícone à esquerda do campo
        prefixIcon: Icon(icon),
        // Borda padrão (não focada)
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        // Borda quando o campo está focado
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        // Borda quando há erro de validação
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
        // Borda focada com erro
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
        ),
        // Preenchimento interno do campo
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),
      ),
    );
  }
}
