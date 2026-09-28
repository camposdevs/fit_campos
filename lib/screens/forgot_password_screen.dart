import 'package:flutter/material.dart';
import '../utils/helpers.dart';
import '../utils/validators.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  void _recover() {
    if (!_form.currentState!.validate()) return;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Solicitação realizada'),
        content: Text('Enviamos as instruções de recuperação para ${_email.text.trim()}.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // fecha o diálogo
              Navigator.pop(context); // volta ao login
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
    showMsg(context, 'Solicitação de recuperação realizada');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RECUPERAR SENHA')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _form,
          child: Column(children: [
            const Text('Informe seu e-mail para receber as instruções de recuperação.',
                style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 20),
            TextFormField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              validator: Validators.email,
              decoration: const InputDecoration(
                  labelText: 'E-mail', prefixIcon: Icon(Icons.email_outlined)),
            ),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: _recover, child: const Text('RECUPERAR SENHA')),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Voltar ao login'),
            ),
          ]),
        ),
      ),
    );
  }
}
