class UserEntity {
  final String email;
  // final String password;
  final String name;
  final String uId;
  final String role;

  // final String cardImageUrl;

  UserEntity({
    required this.email,
    // required this.password,
    required this.name,
    required this.uId,
    required this.role,

    // required this.cardImageUrl,
  });

  toMap() {
    return {
      'email': email,
      'name': name,
      'uId': uId,
      'role': role,

      // 'cardImageUrl': cardImageUrl,
    };
  }
}
