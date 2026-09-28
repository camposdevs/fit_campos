class Validators {
  static String? required(String? v, [String campo = 'Campo']) =>
      (v == null || v.trim().isEmpty) ? '$campo é obrigatório' : null;

  static String? email(String? v) {
    final r = required(v, 'E-mail');
    if (r != null) return r;
    final ok = RegExp(r'^[\w\.\-+]+@[\w\-]+\.[\w\.\-]+$').hasMatch(v!.trim());
    return ok ? null : 'Digite um e-mail válido';
  }

  static String? password(String? v) {
    if (v == null || v.isEmpty) return 'Senha é obrigatória';
    if (v.length < 6) return 'A senha deve ter no mínimo 6 caracteres';
    return null;
  }
}
