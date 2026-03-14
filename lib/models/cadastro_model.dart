/// Modelo que representa um cadastro de usuário.
///
/// Contém os quatro campos coletados no formulário:
/// [nome], [email], [cpf] e [telefone].
class CadastroModel {
  // ─── Atributos ────────────────────────────────────────────────────────────

  /// Nome completo do usuário (máximo 150 caracteres).
  final String nome;

  /// Endereço de e-mail válido do usuário.
  final String email;

  /// CPF formatado (ex.: 000.000.000-00).
  final String cpf;

  /// Telefone formatado (ex.: (00) 00000-0000).
  final String telefone;

  // ─── Construtor ───────────────────────────────────────────────────────────

  /// Cria um [CadastroModel] com todos os campos obrigatórios.
  const CadastroModel({
    required this.nome,
    required this.email,
    required this.cpf,
    required this.telefone,
  });
}
