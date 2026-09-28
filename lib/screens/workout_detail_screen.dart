import 'package:flutter/material.dart';
import '../models/workout_model.dart';
import '../services/app_state.dart';
import '../theme/app_theme.dart';
import '../utils/helpers.dart';

class WorkoutDetailScreen extends StatelessWidget {
  final Workout workout;
  const WorkoutDetailScreen({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;
    return ListenableBuilder(
      listenable: state,
      builder: (context, _) {
        final fav = state.isFavorite(workout.id);
        return Scaffold(
          appBar: AppBar(
            title: Text(workout.name),
            actions: [
              IconButton(
                icon: Icon(fav ? Icons.favorite : Icons.favorite_border,
                    color: fav ? Colors.redAccent : null),
                onPressed: () {
                  state.toggleFavorite(workout.id);
                  showMsg(context, fav ? 'Removido dos favoritos' : 'Adicionado aos favoritos');
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Wrap(spacing: 8, children: [
                Chip(label: Text(workout.muscle)),
                Chip(label: Text(workout.level)),
                Chip(label: Text('${workout.minutes} min')),
              ]),
              const SizedBox(height: 12),
              const Text('Exercícios',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.separated(
                  itemCount: workout.exercises.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (_, i) => Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                        color: AppTheme.surface, borderRadius: BorderRadius.circular(12)),
                    child: Row(children: [
                      CircleAvatar(
                          radius: 14,
                          backgroundColor: AppTheme.orange,
                          child: Text('${i + 1}',
                              style: const TextStyle(color: Colors.white, fontSize: 12))),
                      const SizedBox(width: 12),
                      Expanded(child: Text(workout.exercises[i])),
                    ]),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('REGISTRAR TREINO'),
                onPressed: () {
                  state.registerWorkout(workout.id);
                  showMsg(context, 'Treino registrado no histórico!');
                },
              ),
            ]),
          ),
        );
      },
    );
  }
}
