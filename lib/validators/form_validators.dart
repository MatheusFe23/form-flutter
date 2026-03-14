/// Funções puras de validação utilizadas nos campos do formulário.
///
/// Cada função recebe o valor digitado (pode ser nulo) e retorna
/// uma [String] com a mensagem de erro, ou [null] quando válido.
/// Seguindo o padrão exigido pelo [FormField.validator].
library;

// ─── Validação de Nome ────────────────────────────────────────────────────────

/// Valida o campo Nome.
///
/// Regras:
/// - Campo obrigatório.
/// - Máximo de 150 caracteres (reforço por código além do [maxLength] do field).
String? validarNome(String? valor) {
  // Verifica se o campo está vazio
  if (valor == null || valor.trim().isEmpty) {
    return 'Por favor, informe o nome.';
  }

  // Reforça o limite de 150 caracteres
  if (valor.trim().length > 150) {
    return 'O nome deve ter no máximo 150 caracteres.';
  }

  return null; // Campo válido
}

// ─── Validação de E-mail ──────────────────────────────────────────────────────

/// Valida o campo E-mail.
///
/// Regras:
/// - Campo obrigatório.
/// - Deve seguir o formato padrão de e-mail (RFC-5322 simplificado).
String? validarEmail(String? valor) {
  // Verifica se o campo está vazio
  if (valor == null || valor.trim().isEmpty) {
    return 'Por favor, informe o e-mail.';
  }

  // Expressão regular para validar formato de e-mail
  final regexEmail = RegExp(r'^[\w\.\+\-]+@[\w\-]+\.[a-zA-Z]{2,}$');
  if (!regexEmail.hasMatch(valor.trim())) {
    return 'Informe um e-mail válido.';
  }

  return null; // Campo válido
}

// ─── Validação de CPF ─────────────────────────────────────────────────────────

/// Valida o campo CPF.
///
/// Regras:
/// - Campo obrigatório.
/// - Remove a máscara antes de validar (mantém apenas dígitos).
/// - Deve possuir exatamente 11 dígitos.
/// - Não pode ser uma sequência repetida (ex.: 111.111.111-11).
/// - Aplica o algoritmo oficial de verificação dos dois dígitos verificadores.
String? validarCpf(String? valor) {
  // Verifica se o campo está vazio
  if (valor == null || valor.trim().isEmpty) {
    return 'Por favor, informe o CPF.';
  }

  // Remove tudo que não for dígito (pontos e traço da máscara)
  final cpfSomenteDigitos = valor.replaceAll(RegExp(r'\D'), '');

  // Verifica se tem exatamente 11 dígitos
  if (cpfSomenteDigitos.length != 11) {
    return 'CPF deve conter 11 dígitos.';
  }

  // Rejeita sequências repetidas (ex.: 000.000.000-00, 111.111.111-11...)
  if (RegExp(r'^(\d)\1{10}$').hasMatch(cpfSomenteDigitos)) {
    return 'CPF inválido.';
  }

  // ── Cálculo do 1º dígito verificador ──────────────────────────────────────
  int soma = 0;
  for (int i = 0; i < 9; i++) {
    soma += int.parse(cpfSomenteDigitos[i]) * (10 - i);
  }
  int primeiroDigito = (soma * 10) % 11;
  if (primeiroDigito == 10 || primeiroDigito == 11) primeiroDigito = 0;

  // ── Cálculo do 2º dígito verificador ──────────────────────────────────────
  soma = 0;
  for (int i = 0; i < 10; i++) {
    soma += int.parse(cpfSomenteDigitos[i]) * (11 - i);
  }
  int segundoDigito = (soma * 10) % 11;
  if (segundoDigito == 10 || segundoDigito == 11) segundoDigito = 0;

  // Compara os dígitos calculados com os informados
  final digitosValidos =
      primeiroDigito == int.parse(cpfSomenteDigitos[9]) &&
      segundoDigito == int.parse(cpfSomenteDigitos[10]);

  if (!digitosValidos) {
    return 'CPF inválido.';
  }

  return null; // Campo válido
}

// ─── Validação de Telefone ────────────────────────────────────────────────────

/// Valida o campo Telefone.
///
/// Regras:
/// - Campo obrigatório.
/// - Remove a máscara antes de validar (mantém apenas dígitos).
/// - Aceita somente celular com DDD (11 dígitos): (XX) 9XXXX-XXXX.
String? validarTelefone(String? valor) {
  // Verifica se o campo está vazio
  if (valor == null || valor.trim().isEmpty) {
    return 'Por favor, informe o telefone.';
  }

  // Remove tudo que não for dígito (parênteses, espaço e traço da máscara)
  final telefoneSomenteDigitos = valor.replaceAll(RegExp(r'\D'), '');

  // Aceita somente celular com DDD (11 dígitos)
  if (telefoneSomenteDigitos.length != 11) {
    return 'Informe um celular válido com DDD: (00) 00000-0000.';
  }

  return null; // Campo válido
}
