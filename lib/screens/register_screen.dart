import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/app_state.dart';
import '../utils/helpers.dart';
import '../utils/validators.dart';
import '../widgets/password_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _user = TextEditingController();
  final _pass = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void dispose() {
    for (final c in [_name, _email, _user, _pass, _confirm]) {
      c.dispose();
    }
    super.dispose();
  }

  void _register() {
    if (!_form.currentState!.validate()) {
      showMsg(context, 'Corrija os campos indicados', error: true);
      return;
    }
    final erro = AppState.instance.register(UserModel(
      name: _name.text.trim(),
      email: _email.text.trim(),
      username: _user.text.trim(),
      password: _pass.text,
    ));
    if (erro != null) {
      showMsg(context, erro, error: true);
      return;
    }
    showMsg(context, 'Cadastro realizado com sucesso! Faça login.');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CADASTRO')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _form,
          child: Column(children: [
            TextFormField(
              controller: _name,
              validator: (v) => Validators.required(v, 'Nome'),
              decoration: const InputDecoration(
                  labelText: 'Nome', prefixIcon: Icon(Icons.badge_outlined)),
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              validator: Validators.email,
              decoration: const InputDecoration(
                  labelText: 'E-mail', prefixIcon: Icon(Icons.email_outlined)),
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _user,
              validator: (v) => Validators.required(v, 'Nome de usuário'),
              decoration: const InputDecoration(
                  labelText: 'Nome de usuário', prefixIcon: Icon(Icons.alternate_email)),
            ),
            const SizedBox(height: 14),
            PasswordField(controller: _pass, validator: Validators.password),
            const SizedBox(height: 14),
            PasswordField(
              controller: _confirm,
              label: 'Confirmar senha',
              validator: (v) {
                if (v == null || v.isEmpty) return 'Confirme a senha';
                return v == _pass.text ? null : 'As senhas não coincidem';
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: _register, child: const Text('CADASTRAR')),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Já tem conta? Voltar ao login'),
            ),
          ]),
        ),
      ),
    );
  }
}
