import 'package:flutter/material.dart';
import '../models/workout_model.dart';

const List<Workout> workouts = [
  Workout(id: 1, name: 'Peito e Tríceps', muscle: 'Peito', level: 'Intermediário', minutes: 60, icon: Icons.fitness_center,
      exercises: ['Supino reto 4x10', 'Supino inclinado 3x12', 'Crucifixo 3x12', 'Tríceps testa 3x12', 'Tríceps corda 3x15']),
  Workout(id: 2, name: 'Costas e Bíceps', muscle: 'Costas', level: 'Intermediário', minutes: 60, icon: Icons.sports_gymnastics,
      exercises: ['Puxada frontal 4x10', 'Remada curvada 4x10', 'Remada baixa 3x12', 'Rosca direta 3x12', 'Rosca martelo 3x12']),
  Workout(id: 3, name: 'Pernas Completo', muscle: 'Pernas', level: 'Avançado', minutes: 75, icon: Icons.directions_run,
      exercises: ['Agachamento livre 4x10', 'Leg press 4x12', 'Cadeira extensora 3x15', 'Mesa flexora 3x12', 'Panturrilha em pé 4x20']),
  Workout(id: 4, name: 'Ombros e Abdômen', muscle: 'Ombros', level: 'Iniciante', minutes: 45, icon: Icons.accessibility_new,
      exercises: ['Desenvolvimento 4x10', 'Elevação lateral 3x12', 'Elevação frontal 3x12', 'Abdominal supra 3x20', 'Prancha 3x40s']),
  Workout(id: 5, name: 'Cardio HIIT', muscle: 'Cardio', level: 'Iniciante', minutes: 30, icon: Icons.favorite,
      exercises: ['Aquecimento 5 min', 'Tiro 30s / descanso 30s x10', 'Burpees 3x10', 'Polichinelo 3x30', 'Alongamento 5 min']),
  Workout(id: 6, name: 'Full Body', muscle: 'Corpo todo', level: 'Iniciante', minutes: 50, icon: Icons.bolt,
      exercises: ['Agachamento 3x12', 'Supino 3x12', 'Remada 3x12', 'Desenvolvimento 3x12', 'Prancha 3x40s']),
];

Workout workoutById(int id) => workouts.firstWhere((w) => w.id == id);
