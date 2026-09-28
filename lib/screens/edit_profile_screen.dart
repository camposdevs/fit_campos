import 'package:flutter/material.dart';
import '../services/app_state.dart';
import '../utils/helpers.dart';
import '../utils/validators.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _form = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _user;
  late final TextEditingController _bio;

  @override
  void initState() {
    super.initState();
    final u = AppState.instance.current!;
    _name = TextEditingController(text: u.name);
    _user = TextEditingController(text: u.username);
    _bio = TextEditingController(text: u.bio);
  }

  @override
  void dispose() {
    _name.dispose();
    _user.dispose();
    _bio.dispose();
    super.dispose();
  }

  void _save() {
    if (!_form.currentState!.validate()) return;
    final erro = AppState.instance
        .updateProfile(_name.text.trim(), _user.text.trim(), _bio.text.trim());
    if (erro != null) {
      showMsg(context, erro, error: true);
      return;
    }
    showMsg(context, 'Dados atualizados com sucesso!');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EDITAR PERFIL')),
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
              controller: _user,
              validator: (v) => Validators.required(v, 'Nome de usuário'),
              decoration: const InputDecoration(
                  labelText: 'Nome de usuário', prefixIcon: Icon(Icons.alternate_email)),
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _bio,
              maxLines: 3,
              maxLength: 120,
              decoration: const InputDecoration(labelText: 'Biografia'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _save, child: const Text('SALVAR')),
          ]),
        ),
      ),
    );
  }
}
