import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

/// Fábrica centralizada de [MaskTextInputFormatter].
///
/// Mantém as instâncias dos formatadores em um único lugar,
/// facilitando alterações futuras sem precisar rastrear múltiplos arquivos.
class InputFormatters {
  // Construtor privado impede instanciação — esta classe é puramente estática.
  InputFormatters._();

  // ─── Máscara de CPF ────────────────────────────────────────────────────────

  /// Formata o CPF no padrão: 000.000.000-00
  ///
  /// O `filter` restringe a entrada somente a dígitos numéricos.
  static final cpf = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {'#': RegExp(r'\d')}, // Permite apenas dígitos
    type: MaskAutoCompletionType.lazy, // Aplica a máscara conforme o usuário digita
  );

  // ─── Máscara de Telefone ───────────────────────────────────────────────────

  /// Formata o Telefone no padrão de celular com DDD: (00) 00000-0000
  ///
  /// O `filter` restringe a entrada somente a dígitos numéricos.
  static final telefone = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {'#': RegExp(r'\d')}, // Permite apenas dígitos
    type: MaskAutoCompletionType.lazy, // Aplica a máscara conforme o usuário digita
  );
}
