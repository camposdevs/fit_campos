import 'package:flutter/material.dart';
import '../services/app_state.dart';
import '../theme/app_theme.dart';
import '../utils/helpers.dart';
import 'edit_profile_screen.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _logout(BuildContext context) {
    AppState.instance.logout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
    showMsg(context, 'Você saiu da conta');
  }

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;
    return ListenableBuilder(
      listenable: state,
      builder: (context, _) {
        final u = state.current!;
        return ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const Center(
              child: CircleAvatar(
                radius: 56,
                backgroundColor: AppTheme.orange,
                backgroundImage: AssetImage('assets/images/avatar.png'),
              ),
            ),
            const SizedBox(height: 16),
            Center(
                child: Text(u.name,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
            Center(
                child: Text('@${u.username}',
                    style: const TextStyle(color: AppTheme.orange))),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: AppTheme.surface, borderRadius: BorderRadius.circular(12)),
              child: Text(u.bio.isEmpty ? 'Sem biografia.' : u.bio,
                  textAlign: TextAlign.center),
            ),
            const SizedBox(height: 16),
            Row(children: [
              _stat('Treinos', '${u.history.length}'),
              const SizedBox(width: 12),
              _stat('Favoritos', '${u.favorites.length}'),
            ]),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.edit),
              label: const Text('EDITAR PERFIL'),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const EditProfileScreen())),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text('SAIR'),
              style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
              onPressed: () => _logout(context),
            ),
          ],
        );
      },
    );
  }

  Widget _stat(String label, String value) => Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
              color: AppTheme.surface, borderRadius: BorderRadius.circular(12)),
          child: Column(children: [
            Text(value,
                style: const TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.orange)),
            Text(label, style: const TextStyle(color: Colors.white60)),
          ]),
        ),
      );
}
