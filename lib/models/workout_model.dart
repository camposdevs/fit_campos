import 'package:flutter/material.dart';

class Workout {
  final int id;
  final String name, muscle, level;
  final int minutes;
  final IconData icon;
  final List<String> exercises;

  const Workout({
    required this.id,
    required this.name,
    required this.muscle,
    required this.level,
    required this.minutes,
    required this.icon,
    required this.exercises,
  });
}
