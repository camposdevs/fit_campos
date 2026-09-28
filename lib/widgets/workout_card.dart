import 'package:flutter/material.dart';
import '../models/workout_model.dart';
import '../theme/app_theme.dart';

class WorkoutCard extends StatelessWidget {
  final Workout workout;
  final bool isFavorite;
  final VoidCallback onTap, onFavorite;

  const WorkoutCard({
    super.key,
    required this.workout,
    required this.isFavorite,
    required this.onTap,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.orange.withOpacity(0.3)),
          ),
          child: Row(children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: AppTheme.orange.withOpacity(0.15),
              child: Icon(workout.icon, color: AppTheme.orange, size: 28),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(workout.name,
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('${workout.level} • ${workout.minutes} min',
                    style: const TextStyle(color: Colors.white60)),
              ]),
            ),
            IconButton(
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.redAccent : Colors.white54),
              onPressed: onFavorite,
            ),
          ]),
        ),
      ),
    );
  }
}
