import 'package:flutter/material.dart';
import '../data/workouts_data.dart';
import '../services/app_state.dart';
import '../utils/helpers.dart';
import '../widgets/workout_card.dart';
import 'workout_detail_screen.dart';

class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;
    return ListenableBuilder(
      listenable: state,
      builder: (context, _) {
        final firstName = state.current!.name.split(' ').first;
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('Olá, $firstName! 👋',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text('Escolha o treino de hoje',
                style: TextStyle(color: Colors.white60)),
            const SizedBox(height: 16),
            for (final w in workouts)
              WorkoutCard(
                workout: w,
                isFavorite: state.isFavorite(w.id),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => WorkoutDetailScreen(workout: w))),
                onFavorite: () {
                  final was = state.isFavorite(w.id);
                  state.toggleFavorite(w.id);
                  showMsg(context, was ? 'Removido dos favoritos' : 'Adicionado aos favoritos');
                },
              ),
          ],
        );
      },
    );
  }
}
