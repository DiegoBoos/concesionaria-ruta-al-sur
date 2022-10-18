class UserRuta {
  String email;
  String fullName;
  List roles;

  UserRuta({
    required this.email,
    required this.fullName,
    required this.roles,
  });

  static UserRuta fromJson(Map<String, dynamic> map) {
    return UserRuta(
      email: map['email'],
      fullName: map['fullName'],
      roles: map['roles'],
    );
  }
}
