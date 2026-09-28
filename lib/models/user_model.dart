class UserModel {
  String name, email, username, password, bio;
  List<int> favorites;
  // Cada item: {'id': idDoTreino, 'date': dataIso}
  List<Map<String, dynamic>> history;

  UserModel({
    required this.name,
    required this.email,
    required this.username,
    required this.password,
    this.bio = 'Focado nos treinos! 💪',
    List<int>? favorites,
    List<Map<String, dynamic>>? history,
  })  : favorites = favorites ?? [],
        history = history ?? [];

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'username': username,
        'password': password,
        'bio': bio,
        'favorites': favorites,
        'history': history,
      };

  factory UserModel.fromJson(Map<String, dynamic> j) => UserModel(
        name: j['name'],
        email: j['email'],
        username: j['username'],
        password: j['password'],
        bio: j['bio'] ?? '',
        favorites: List<int>.from(j['favorites'] ?? []),
        history: (j['history'] as List? ?? [])
            .map((e) => Map<String, dynamic>.from(e))
            .toList(),
      );
}
