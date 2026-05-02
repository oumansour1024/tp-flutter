
class User {
  final int id;
  final String name;
  final String email;
  final String? avatar;
  final String? username;
  final String? phone;
  final String? website;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
    this.username,
    this.phone,
    this.website,
  });

  // Pour JSONPlaceholder API
  factory User.fromJsonPlaceholder(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      username: json['username'],
      phone: json['phone'],
      website: json['website'],
      avatar: 'https://robohash.org/${json['id']}?set=set5',
    );
  }

  // Pour DummyJSON API
  factory User.fromDummyJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: '${json['firstName']} ${json['lastName']}',
      email: json['email'],
      username: json['username'],
      phone: json['phone'],
      website: json['website'],
      avatar: json['image'] ?? 'https://robohash.org/${json['id']}?set=set5',
    );
  }
}