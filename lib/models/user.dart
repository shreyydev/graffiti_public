class GraffitiUser {
  String username;
  String firstName;
  String lastName;
  String email;

  GraffitiUser({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
  });

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'username': username,
        'email': email,
      };

  factory GraffitiUser.fromJson(dynamic json) {
    return GraffitiUser(
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        email: json['email'],
        username: json['username']);
  }

  @override
  String toString() {
    return "{$firstName , $lastName, $username, $email}";
  }
}
