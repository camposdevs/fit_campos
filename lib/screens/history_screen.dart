import 'package:flutter/material.dart';
import '../data/workouts_data.dart';
import '../services/app_state.dart';
import '../theme/app_theme.dart';
import '../utils/helpers.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;
    return ListenableBuilder(
      listenable: state,
      builder: (context, _) {
        final history = state.current!.history;
        if (history.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Text('Nenhum treino registrado ainda.\nAbra um treino e toque em "Registrar treino".',
                  textAlign: TextAlign.center, style: TextStyle(color: Colors.white60)),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: history.length,
          itemBuilder: (_, i) {
            final w = workoutById(history[i]['id'] as int);
            return Card(
              color: AppTheme.surface,
              child: ListTile(
                leading: Icon(w.icon, color: AppTheme.orange),
                title: Text(w.name),
                subtitle: Text(formatDate(history[i]['date'] as String)),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () {
                    state.removeHistory(i);
                    showMsg(context, 'Registro removido');
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
