import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

/// Guarda usuários e o usuário logado. Os dados ficam salvos localmente.
class AppState extends ChangeNotifier {
  AppState._();
  static final AppState instance = AppState._();

  late SharedPreferences _prefs;
  List<UserModel> _users = [];
  UserModel? current;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    final raw = _prefs.getString('users');
    if (raw != null) {
      _users = (jsonDecode(raw) as List)
          .map((e) => UserModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }
  }

  Future<void> _save() =>
      _prefs.setString('users', jsonEncode(_users.map((u) => u.toJson()).toList()));

  /// Retorna mensagem de erro, ou null se deu certo.
  String? register(UserModel u) {
    if (_users.any((x) => x.email.toLowerCase() == u.email.toLowerCase())) {
      return 'Já existe uma conta com esse e-mail';
    }
    if (_users.any((x) => x.username.toLowerCase() == u.username.toLowerCase())) {
      return 'Nome de usuário já está em uso';
    }
    _users.add(u);
    _save();
    return null;
  }

  bool login(String id, String password) {
    final key = id.trim().toLowerCase();
    for (final u in _users) {
      if ((u.email.toLowerCase() == key || u.username.toLowerCase() == key) &&
          u.password == password) {
        current = u;
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  void logout() {
    // Sem notifyListeners: as telas logadas usam current! e quebrariam ao redesenhar.
    current = null;
  }

  String? updateProfile(String name, String username, String bio) {
    final taken = _users.any((u) =>
        u != current && u.username.toLowerCase() == username.toLowerCase());
    if (taken) return 'Nome de usuário já está em uso';
    current!
      ..name = name
      ..username = username
      ..bio = bio;
    _save();
    notifyListeners();
    return null;
  }

  bool isFavorite(int id) => current!.favorites.contains(id);

  void toggleFavorite(int id) {
    final f = current!.favorites;
    f.contains(id) ? f.remove(id) : f.add(id);
    _save();
    notifyListeners();
  }

  void registerWorkout(int id) {
    current!.history.insert(0, {'id': id, 'date': DateTime.now().toIso8601String()});
    _save();
    notifyListeners();
  }

  void removeHistory(int index) {
    current!.history.removeAt(index);
    _save();
    notifyListeners();
  }
}
