import 'package:flutter/material.dart';
import '../services/app_state.dart';
import '../theme/app_theme.dart';
import '../utils/helpers.dart';
import '../utils/validators.dart';
import '../widgets/password_field.dart';
import 'forgot_password_screen.dart';
import 'home_shell.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  final _id = TextEditingController();
  final _pass = TextEditingController();

  @override
  void dispose() {
    _id.dispose();
    _pass.dispose();
    super.dispose();
  }

  void _login() {
    if (!_form.currentState!.validate()) {
      showMsg(context, 'Preencha os campos obrigatórios', error: true);
      return;
    }
    if (AppState.instance.login(_id.text, _pass.text)) {
      showMsg(context, 'Login realizado com sucesso!');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomeShell()));
    } else {
      showMsg(context, 'E-mail/usuário ou senha inválidos', error: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _form,
              child: Column(children: [
                const Icon(Icons.fitness_center, size: 72, color: AppTheme.orange),
                const SizedBox(height: 8),
                const Text('FIT CAMPOS',
                    style: TextStyle(
                        fontSize: 32, fontWeight: FontWeight.w900, letterSpacing: 4)),
                const Text('Seu treino, sua evolução',
                    style: TextStyle(color: Colors.white60)),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _id,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) => Validators.required(v, 'E-mail ou usuário'),
                  decoration: const InputDecoration(
                      labelText: 'E-mail ou usuário',
                      prefixIcon: Icon(Icons.person_outline)),
                ),
                const SizedBox(height: 14),
                PasswordField(
                    controller: _pass,
                    validator: (v) => Validators.required(v, 'Senha')),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const ForgotPasswordScreen())),
                    child: const Text('Esqueci minha senha'),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(onPressed: _login, child: const Text('ENTRAR')),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const RegisterScreen())),
                  child: const Text('Não tem conta? Cadastre-se'),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
